import 'package:beacon/src/domain/models/impl/http_error.dart';
import 'package:beacon/src/domain/models/impl/http_request.dart';
import 'package:beacon/src/domain/models/impl/http_response.dart';

/// Represents an HTTP call in the Beacon application.
///
/// This class is used to encapsulate the details of an HTTP request and response,
/// including the request method, URL, headers, body, and the response status code,
/// headers, and body.
///
/// The `BeaconHttpCall` class is typically used for logging and debugging purposes
/// to track the HTTP interactions within the application.
///
class BeaconHttpCall {
  ///
  const BeaconHttpCall({
    required this.xRequestId,
    required this.request,
    required this.response,
    required this.error,
  });

  /// The unique identifier for the HTTP request.
  ///
  /// This ID is used to track and correlate the request throughout its lifecycle.
  final String xRequestId;

  /// The HTTP request details.
  ///
  /// This includes information such as the URL, headers, and body of the request.
  final BeaconHttpRequest request;

  /// The HTTP response details.
  ///
  /// This includes information such as the status code, headers, and body of the response.
  final BeaconHttpResponse response;

  /// The HTTP error details, if any.
  ///
  /// This includes information about any errors that occurred during the HTTP request or response.
  final BeaconHttpError error;
}
