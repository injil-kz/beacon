// TODO: Finish implementation of BeaconHttpError
class BeaconHttpError {
  final int statusCode;
  final String message;
  final String? details;

  BeaconHttpError({
    required this.statusCode,
    required this.message,
    this.details,
  });

  @override
  String toString() {
    return 'BeaconHttpError{statusCode: $statusCode, message: $message, details: $details}';
  }
}
