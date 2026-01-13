library beacon_supabase_adapter;

import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:injil_beacon/injil_beacon.dart';

class BeaconSupabaseClient extends http.BaseClient {
  final http.Client _inner;
  final BeaconConfiguration beaconConfiguration;

  BeaconSupabaseClient({
    http.Client? inner,
    required this.beaconConfiguration,
  }) : _inner = inner ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final generatedId = generateRandomId(11);
    request.headers['x-request-id'] = generatedId;

    Object? body;
    if (request is http.Request) {
      try {
        if (request.body.isNotEmpty) {
          body = request.body;
        }
      } catch (_) {}
    } else if (request is http.MultipartRequest) {
      body = 'Multipart Request: ${request.fields}';
    }

    beaconConfiguration.repo.saveRequest(
      BeaconHttpRequest(
        method: BeaconMethodParser.fromString(request.method),
        path: request.url.toString(),
        timestampInMilliseconds: DateTime.now().millisecondsSinceEpoch.toDouble(),
        body: body,
        query: request.url.queryParameters,
        connectionTimeout: null,
        receiveTimeout: null,
        headers: request.headers,
        xRequestId: generatedId,
      ),
    );

    try {
      final response = await _inner.send(request);
      final bytes = await response.stream.toBytes();

      String? bodyString;
      try {
        bodyString = utf8.decode(bytes);
      } catch (_) {
        bodyString = 'Binary data or mixed encoding';
      }

      beaconConfiguration.repo.saveResponse(
        BeaconHttpResponse(
          url: request.url.toString(),
          statusCode: response.statusCode,
          timestampInMilliseconds: DateTime.now().millisecondsSinceEpoch.toDouble(),
          body: bodyString,
          headers: response.headers,
          xRequestId: generatedId,
          size: bytes.length,
        ),
      );

      return http.StreamedResponse(
        http.ByteStream.fromBytes(bytes),
        response.statusCode,
        contentLength: response.contentLength,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    } catch (e) {
      beaconConfiguration.repo.saveError(
        BeaconHttpError(
          statusCode: -1,
          message: e.toString(),
          details: 'Error: ${e.toString()}',
          xRequestId: generatedId,
        ),
      );
      rethrow;
    }
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
