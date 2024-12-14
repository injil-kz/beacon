library beacon_dio_adapter;

import 'dart:convert';
import 'dart:math';

import 'package:beacon/beacon.dart';
import 'package:dio/dio.dart';

class BeaconDioAdapter extends QueuedInterceptor {
  final BeaconConfiguration beaconConfiguration;

  BeaconDioAdapter({
    required this.beaconConfiguration,
  }) : super();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final generatedId = generateRandomId(11);
    options.headers['x-request-id'] = generatedId;
    beaconConfiguration.repo.saveRequest(
      BeaconHttpRequest(
        method: BeaconMethodParser.fromString(options.method),
        path: options.path.toString(),
        timestampInMilliseconds: DateTime.now().millisecondsSinceEpoch.toDouble(),
        body: options.data,
        query: options.queryParameters,
        connectionTimeout: options.connectTimeout?.inMilliseconds.toDouble(),
        receiveTimeout: options.receiveTimeout?.inMilliseconds.toDouble(),
        headers: options.headers,
        xRequestId: generatedId,
      ),
    );

    super.onRequest(options.copyWith(), handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final generatedId = response.requestOptions.headers['x-request-id'];
    beaconConfiguration.repo.saveResponse(
      BeaconHttpResponse(
        statusCode: response.statusCode ?? 0,
        timestampInMilliseconds: DateTime.now().millisecondsSinceEpoch.toDouble(),
        body: response.data,
        headers: response.headers.map,
        xRequestId: generatedId,
        size: response.data == null ? 0 : utf8.encode(response.data.toString()).length,
      ),
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException exp, ErrorInterceptorHandler handler) {
    final generatedId = exp.requestOptions.headers['x-request-id'];

    beaconConfiguration.repo.saveError(
      BeaconHttpError(
        statusCode: exp.response?.statusCode ?? -1,
        message: exp.message ?? exp.error.toString(),
        details: 'Type:${exp.type}\nError: ${exp.error.toString()}',
        xRequestId: generatedId,
      ),
    );
    super.onError(exp, handler);
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
