import 'package:beacon/src/domain/models/http_message.dart';

/// A class representing the HTTP response received by the Beacon application.
///
/// The `BeaconHttpResponse` class encapsulates the details of an HTTP response,
/// including the status code, headers, and body of the response.
///
/// This class is used to handle and process the responses received from HTTP
/// requests made by the Beacon application.
///
/// Example usage:
/// ```dart
/// final response = BeaconHttpResponse(
///   statusCode: 200,
///   headers: {'Content-Type': 'application/json'},
///   body: '{"message": "Success"}',
/// );
/// ```
///
/// The `statusCode` indicates the HTTP status code of the response.
/// The `headers` contain the HTTP headers returned by the server.
/// The `body` contains the response body as a string.
///
/// Parameters:
/// - `statusCode`: The HTTP status code of the response.
/// - `headers`: A map of HTTP headers returned by the server.
/// - `body`: The response body as a string.
class BeaconHttpResponse extends BeaconHttpMessage {
  /// Constructor for creating a new `BeaconHttpResponse` instance.
  const BeaconHttpResponse({
    required this.statusCode,
    required this.headers,
    required this.timestampInMilliseconds,
    super.xRequestId,
    this.body,
    this.responseTimeInMilliseconds,
    this.cookie,
  });

  /// Represents an HTTP response with headers, body, cookies, and timing information.
  /// `statusCode` is the HTTP status code of the response.
  final int statusCode;

  /// `headers` is a map containing the HTTP headers of the response.
  final Map<String, dynamic>? headers;

  /// `body` is the content of the HTTP response, which can be of any type.
  final dynamic body;

  /// `cookie` is a map containing the cookies associated with the response.
  final Map<String, dynamic>? cookie;

  /// `timestampInMilliseconds` is the timestamp of the response in milliseconds.
  final double timestampInMilliseconds;

  /// `responseTimeInMilliseconds` is the time taken to receive the response in milliseconds, which is optional.
  final double? responseTimeInMilliseconds;
}
