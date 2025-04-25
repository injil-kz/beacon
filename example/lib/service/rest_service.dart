import 'package:beacon_dio_adapter/beacon_dio_adapter.dart';
import 'package:dio/dio.dart';
import 'package:injil_beacon/injil_beacon.dart';

class RestService {
  Dio? _dio;

  Future<void> simulateHttpCalls() async {
    _dio = null;
    _dio = Dio(
      BaseOptions(connectTimeout: Duration(seconds: 5), receiveTimeout: Duration(seconds: 5), sendTimeout: Duration(seconds: 5)),
    );
    _dio?.interceptors.add(BeaconDioAdapter(beaconConfiguration: DefaultBeaconConfiguration()));

    try {
      await _dio!.get('https://httpstat.us/403');
      print('GET https://httpstat.us/403 (expected error)');
    } catch (e) {
      print('Caught error during GET https://httpstat.us/403: $e');
    }

    try {
      await _dio!.delete(
        'https://jsonplaceholder.typicode.com/?posts=-1', // Likely an invalid endpoint or method for this URL
        data: {'id': 1, 'title': 'foo', 'body': 'bar', 'userId': 1},
      );
      print('DELETE https://jsonplaceholder.typicode.com/?posts=-1 (expected error)');
    } catch (e) {
      print('Caught error during DELETE https://jsonplaceholder.typicode.com/?posts=-1: $e');
    }

    try {
      await _dio!.get('https://jsonplaceholder.typicode.com/posts', queryParameters: {'_limit': 5});
      print('GET Posts successful');
    } catch (e) {
      print('Error during GET https://jsonplaceholder.typicode.com/posts: $e');
    }

    await Future.delayed(Duration(seconds: 3));

    try {
      await _dio!.get('https://jsonplaceholder.typicode.com/comments', queryParameters: {'postId': 1});
      print('GET Comments successful');
    } catch (e) {
      print('Error during GET https://jsonplaceholder.typicode.com/comments: $e');
    }

    await Future.delayed(Duration(seconds: 3));

    try {
      await _dio!.post('https://jsonplaceholder.typicode.com/posts', data: {'title': 'foo', 'body': 'bar', 'userId': 1});
      print('POST Post successful');
    } catch (e) {
      print('Error during POST https://jsonplaceholder.typicode.com/posts: $e');
    }

    await Future.delayed(Duration(seconds: 3));

    try {
      // POST with form-urlencoded data
      await _dio!.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {'title': 'foo_encoded', 'body': 'bar_encoded', 'userId': 2},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print('POST (form-urlencoded) Post successful');
    } catch (e) {
      print('Error during POST (form-urlencoded) https://jsonplaceholder.typicode.com/posts: $e');
    }

    await Future.delayed(Duration(seconds: 3));

    try {
      await _dio!.put(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {'id': 1, 'title': 'foo', 'body': 'bar', 'userId': 1},
      );
      print('PUT Post successful');
    } catch (e) {
      print('Error during PUT https://jsonplaceholder.typicode.com/posts/1: $e');
    }

    await Future.delayed(Duration(seconds: 3));

    try {
      await _dio!.delete('https://jsonplaceholder.typicode.com/posts/1');
      print('DELETE Post successful');
    } catch (e) {
      print('Error during DELETE https://jsonplaceholder.typicode.com/posts/1: $e');
    }

    await Future.delayed(Duration(seconds: 3));

    try {
      await _dio!.patch(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {'id': 1, 'title': 'foo', 'body': 'bar', 'userId': 1},
      );
      print('PATCH Post successful');
    } catch (e) {
      print('Error during PATCH https://jsonplaceholder.typicode.com/posts/1: $e');
    }

    await Future.delayed(Duration(seconds: 3));

    try {
      await _dio!.head(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {
          // Note: HEAD requests typically don't have a body, but Dio allows it.
          'id': 1,
          'title': 'foo',
          'body': 'bar',
          'userId': 1,
        },
      );
      print('HEAD Post successful');
    } catch (e) {
      print('Error during HEAD https://jsonplaceholder.typicode.com/posts/1: $e');
    }
  }
}
