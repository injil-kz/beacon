import 'dart:convert';

import 'package:beacon/beacon.dart';
import 'package:dio/dio.dart';
import 'dart:math';

class RestService {
  Dio? _dio;

  Future<void> simulateHttpCalls() async {
    _dio = null;
    _dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        sendTimeout: Duration(seconds: 5),
      ),
    );
    _dio?.interceptors.add(
      BeaconDioAdapter(beaconConfiguration: BeaconConfiguration()),
    );

    await _dio!.get(
      'https://jsonplaceholder.typicode.com/posts',
      queryParameters: {
        '_limit': 5,
      },
    );
    print('GET Posts');
    await _dio!.get(
      'https://jsonplaceholder.typicode.com/comments',
      queryParameters: {
        'postId': 1,
      },
    );
    print('GET Comments');
    await _dio!.post(
      'https://jsonplaceholder.typicode.com/posts',
      data: {
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      },
    );
    print('POST Post');
    await _dio!.put(
      'https://jsonplaceholder.typicode.com/posts/1',
      data: {
        'id': 1,
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      },
    );
    print('PUT Post');
    await _dio!.delete(
      'https://jsonplaceholder.typicode.com/posts/1',
    );
    print('DELETE Post');
    await _dio!.patch(
      'https://jsonplaceholder.typicode.com/posts/1',
      data: {
        'id': 1,
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      },
    );
    print('PATCH Post');

    await _dio!.head(
      'https://jsonplaceholder.typicode.com/posts/1',
      data: {
        'id': 1,
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      },
    );
    print('HEAD Post');
  }
}

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
        statusCode: exp.response?.statusCode ?? 0,
        message: exp.message ?? exp.error.toString(),
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
