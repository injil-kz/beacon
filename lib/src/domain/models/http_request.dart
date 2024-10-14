sealed class HttpRequest {
  const HttpRequest(
    this.path, {
    required this.body,
    required this.query,
    required this.response,
    required this.connectionTimeout,
    required this.receiveTimeout,
    required this.headers,
  });

  final String path;
  final Map<String,dynamic>? response;
  final double? connectionTimeout;
  final double? receiveTimeout;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? query;

  String get requestInCurl;

  String get pathWithQueryParameters => '$path${query ?? ''}';

  String get queryInRaw => query.toString();

  String toCurl() {
    return '''
      curl -X $requestInCurl
      ${(headers ?? {}).isNotEmpty ? '-H $headers' : ''} 
      ${(body ?? {}).isNotEmpty ? '-d $body' : ''}
      $pathWithQueryParameters
    ''';
  }
}

final class HttpRequestGet extends HttpRequest {
  const HttpRequestGet(super.path,
      {required super.response,
      required super.connectionTimeout,
      required super.receiveTimeout,
      required super.headers,
      required super.body,
      required super.query});

  @override
  String get requestInCurl => 'GET';
}

final class HttpRequestPost extends HttpRequest {
  const HttpRequestPost(
    super.path, {
    required super.response,
    required super.connectionTimeout,
    required super.receiveTimeout,
    required super.headers,
    required super.body,
    required super.query,
  });

  @override
  String get requestInCurl => 'POST';
}

final class HttpRequestPut extends HttpRequest {
  const HttpRequestPut(
    super.path, {
    required super.response,
    required super.connectionTimeout,
    required super.receiveTimeout,
    required super.headers,
    required super.body,
    required super.query,
  });

  @override
  String get requestInCurl => 'PUT';
}

final class HttpRequestDelete extends HttpRequest {
  const HttpRequestDelete(
    super.path, {
    required super.response,
    required super.connectionTimeout,
    required super.receiveTimeout,
    required super.headers,
    required super.body,
    required super.query,
  });

  @override
  String get requestInCurl => 'DELETE';
}

final class HttpRequestPatch extends HttpRequest {
  const HttpRequestPatch(
    super.path, {
    required super.response,
    required super.connectionTimeout,
    required super.receiveTimeout,
    required super.headers,
    required super.body,
    required super.query,
  });

  @override
  String get requestInCurl => 'PATCH';
}
