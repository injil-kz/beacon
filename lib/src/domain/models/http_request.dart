sealed class HttpRequest {
  const HttpRequest(
    this.path, {
    required this.timestampInMilliseconds,
    required this.body,
    required this.query,
    required this.response,
    required this.connectionTimeout,
    required this.receiveTimeout,
    required this.headers,
  });

  final String path;
  final Map<String, dynamic>? response;
  final double? connectionTimeout;
  final double? receiveTimeout;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? query;
  final double? timestampInMilliseconds;

  String get _requestInCurl;

  String get _pathWithQueryParameters => '$path$_queryInRaw';

  String get _queryInRaw => query.toString();

  String toCurl() {
    return '''
      curl -X $_requestInCurl
      ${(headers ?? {}).isNotEmpty ? '-H $headers' : ''} 
      ${(body ?? {}).isNotEmpty ? '-d $body' : ''}
      $_pathWithQueryParameters
    ''';
  }
}

final class HttpRequestGet extends HttpRequest {
  const HttpRequestGet(
    super.path, {
    required super.response,
    required super.connectionTimeout,
    required super.receiveTimeout,
    required super.headers,
    required super.body,
    required super.query,
    required super.timestampInMilliseconds,
  });

  @override
  String get _requestInCurl => 'GET';
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
    required super.timestampInMilliseconds,
  });

  @override
  String get _requestInCurl => 'POST';
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
    required super.timestampInMilliseconds,
  });

  @override
  String get _requestInCurl => 'PUT';
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
    required super.timestampInMilliseconds,
  });

  @override
  String get _requestInCurl => 'DELETE';
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
    required super.timestampInMilliseconds,
  });

  @override
  String get _requestInCurl => 'PATCH';
}
