import 'package:dio/dio.dart';

class RestService {
  Dio? _dio;

  Future<void> simulateHttpCalls() async {
    _dio = null;
    _dio = Dio();

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
