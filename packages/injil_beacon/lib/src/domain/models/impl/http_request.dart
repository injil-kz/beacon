import 'dart:convert';

import 'package:injil_beacon/src/domain/models/http_message.dart';

/// Represents an HTTP request.
///
/// This class encapsulates the details of an HTTP request, including
/// the method, headers, body, and other relevant information.
///
/// Example usage:
///
/// ```dart
/// final request = BeaconHttpRequest(
///   method: 'GET',
///   url: 'https://example.com/api',
///   headers: {'Authorization': 'Bearer token'},
/// );
/// ```
///
/// Properties:
/// - `method`: The HTTP method (e.g., GET, POST, PUT, DELETE).
/// - `url`: The URL to which the request is sent.
/// - `headers`: A map of headers to include in the request.
/// - `body`: The body of the request, if applicable.
class BeaconHttpRequest extends BeaconHttpMessage {
  /// Constructor for creating a new `HttpRequest` instance.
  const BeaconHttpRequest({
    required this.method,
    required this.path,
    required this.timestampInMilliseconds,
    required this.body,
    required this.query,
    required this.connectionTimeout,
    required this.receiveTimeout,
    required this.headers,
    super.xRequestId,
  }) : super();

  /// [method] - The HTTP method to be used for the request (e.g., GET, POST).
  final BeaconHttpMethod method;

  /// [path] - The path of the request URL.
  final String path;

  /// [connectionTimeout] - The timeout duration for establishing a connection, in milliseconds.
  final double? connectionTimeout;

  /// [receiveTimeout] - The timeout duration for receiving data, in milliseconds.
  final double? receiveTimeout;

  /// [headers] - The headers to be included in the request.
  final Map<String, dynamic>? headers;

  /// [body] - The body of the request, which can be a Map or a primitive type.
  final dynamic body; // Changed to dynamic to accept both Map and primitive types

  /// [query] - The query parameters to be included in the request URL.
  final Map<String, dynamic>? query;

  /// [timestampInMilliseconds] - The timestamp of the request in milliseconds.
  final double timestampInMilliseconds;

  /// Converts the HTTP request to a cURL command string.
  ///
  /// This getter method generates a cURL command that can be used to
  /// replicate the HTTP request in a terminal. It includes the URL,
  /// headers, and body of the request.
  ///
  /// Returns a [String] representing the cURL command.
  String get cURL {
    final headersString = headers?.entries.map((e) => '-H "${e.key}: ${e.value}"').join(' ') ?? '';
    final bodyString = body != null
        ? body is String
            ? '-d "$body"'
            : '-d ${jsonEncode(body)}'
        : '';
    return 'curl -X $_requestInCurl $headersString $bodyString $_pathWithQueryParameters';
  }

  String get _requestInCurl => method.name;

  String get _pathWithQueryParameters => '$path${_queryInRaw.isNotEmpty ? '?$_queryInRaw' : ''}';

  String get _queryInRaw => query?.entries.map((e) => '${e.key}=${e.value}').join('&') ?? '';
}
