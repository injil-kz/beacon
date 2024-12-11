import 'package:beacon/src/domain/models/http_message.dart';

/// A class representing an HTTP error in the Beacon application.
///
/// This class is used to encapsulate details about HTTP errors that occur
/// during network operations within the application. It provides a way to
/// handle and manage errors in a structured manner.
class BeaconHttpError extends BeaconHttpMessage {
  /// Creates a new instance of [BeaconHttpError].
  const BeaconHttpError({
    required this.statusCode,
    required this.message,
    this.details,
    super.xRequestId,
  });

  /// [statusCode] is the HTTP status code of the error.
  final int statusCode;

  /// [message] is a brief description of the error.
  final String message;

  /// [details] provides additional information about the error, if available.
  final String? details;

  @override
  String toString() {
    return 'BeaconHttpError{statusCode: $statusCode, message: $message, details: $details}';
  }
}
