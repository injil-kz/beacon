import 'package:beacon/src/domain/models/http_request.dart';

abstract interface class BeaconRepository {
  Future<List<HttpRequest>> fetchHttpRequests();

  Future<void> saveHttpRequest();
}
