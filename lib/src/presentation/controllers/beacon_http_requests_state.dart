import 'package:beacon/src/domain/models/http_request.dart';

class BeaconHttpRequestsState {
  const BeaconHttpRequestsState({required this.httpRequests});

  final List<HttpRequest> httpRequests;
}
