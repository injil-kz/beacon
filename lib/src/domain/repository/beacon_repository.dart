import 'package:beacon/src/domain/models/http_request.dart';

abstract interface class BeaconRepository {
  Stream<List<HttpRequest>> listenHttpRequests();

  Future<void> addHttpRequestEvent(HttpRequest request);
}
