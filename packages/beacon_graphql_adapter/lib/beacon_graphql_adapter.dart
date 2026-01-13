library beacon_graphql_adapter;

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:gql/language.dart';
import 'package:graphql/client.dart';
import 'package:injil_beacon/injil_beacon.dart';

class BeaconGraphqlLink extends Link {
  final BeaconConfiguration beaconConfiguration;
  final String? uri;

  BeaconGraphqlLink({
    required this.beaconConfiguration,
    this.uri,
  });

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    final generatedId = generateRandomId(11);

    // Attempt to get existing headers or create new map
    final Map<String, String> headers = {};
    final contextEntry = request.context.entry<HttpLinkHeaders>();
    if (contextEntry != null) {
      headers.addAll(contextEntry.headers);
    }

    // Add x-request-id if not present
    if (!headers.containsKey('x-request-id')) {
      headers['x-request-id'] = generatedId;
    }

    // Update context with modified headers
    final modifiedRequest = request.updateContextEntry<HttpLinkHeaders>(
      (entry) => HttpLinkHeaders(headers: headers),
    );

    beaconConfiguration.repo.saveRequest(
      BeaconHttpRequest(
        method: BeaconMethodParser.fromString('POST'),
        path: uri ?? 'GraphQL',
        timestampInMilliseconds: DateTime.now().millisecondsSinceEpoch.toDouble(),
        body: {
          'operationName': request.operation.operationName,
          'variables': request.variables,
          'query': printNode(request.operation.document),
        },
        query: request.variables,
        connectionTimeout: null,
        receiveTimeout: null,
        headers: headers,
        xRequestId: generatedId,
      ),
    );

    return forward!(modifiedRequest).transform(
      StreamTransformer.fromHandlers(
        handleData: (Response response, EventSink<Response> sink) {
          _saveResponse(response, generatedId);
          sink.add(response);
        },
        handleError: (Object error, StackTrace stackTrace, EventSink<Response> sink) {
          _saveError(error, stackTrace, generatedId);
          sink.addError(error, stackTrace);
        },
      ),
    );
  }

  void _saveResponse(Response response, String generatedId) {
    int statusCode = 200;
    Map<String, String>? headers;

    try {
      final httpResponseContext = response.context.entry<HttpLinkResponseContext>();
      if (httpResponseContext != null) {
        statusCode = httpResponseContext.statusCode;
        headers = httpResponseContext.headers;
      }
    } catch (_) {}

    final body = {
      if (response.data != null) 'data': response.data,
      if (response.errors != null) 'errors': response.errors!.map((e) => e.toString()).toList(),
    };

    beaconConfiguration.repo.saveResponse(
      BeaconHttpResponse(
        url: uri ?? 'GraphQL',
        statusCode: statusCode,
        timestampInMilliseconds: DateTime.now().millisecondsSinceEpoch.toDouble(),
        body: body,
        headers: headers,
        xRequestId: generatedId,
        size: utf8.encode(jsonEncode(body)).length,
      ),
    );
  }

  void _saveError(Object error, StackTrace stackTrace, String generatedId) {
    // If it's a LinkException or similar
    String message = error.toString();
    int statusCode = -1;

    beaconConfiguration.repo.saveError(
      BeaconHttpError(
        statusCode: statusCode,
        message: message,
        details: 'Stacktrace: $stackTrace',
        xRequestId: generatedId,
      ),
    );

    // Also close the loop visually
    beaconConfiguration.repo.saveResponse(
      BeaconHttpResponse(
        url: uri ?? 'GraphQL',
        statusCode: statusCode,
        timestampInMilliseconds: DateTime.now().millisecondsSinceEpoch.toDouble(),
        body: {'error': message},
        headers: {},
        xRequestId: generatedId,
        size: utf8.encode(message).length,
      ),
    );
  }

  String generateRandomId(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final result = String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
    return result;
  }
}
