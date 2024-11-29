import 'package:beacon/src/domain/models/impl/http_error.dart';
import 'package:beacon/src/domain/models/impl/http_request.dart';
import 'package:beacon/src/domain/models/impl/http_response.dart';

class BeaconHttpCall {
  BeaconHttpCall({
    required this.xRequestId,
    required this.request,
    required this.response,
    required this.error,
  });

  final String xRequestId;
  final BeaconHttpRequest request;
  final BeaconHttpResponse response;
  final BeaconHttpError error;
}
