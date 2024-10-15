import 'package:beacon/src/domain/models/http_request.dart';
import 'package:beacon/src/domain/repository/beacon_repository.dart';

class BeaconInterceptor {
  const BeaconInterceptor({required BeaconRepository beaconRepository}) : _beaconRepository = beaconRepository;

  final BeaconRepository _beaconRepository;

  Future<void> onRequest(HttpRequest httpRequest) async {
    _beaconRepository.addHttpRequestEvent(httpRequest);
  }

  Future<void> onResponse(HttpRequest httpRequest) async {
    _beaconRepository.addHttpRequestEvent(httpRequest);
  }

  Future<void> onError(HttpRequest httpRequest) async {
    _beaconRepository.addHttpRequestEvent(httpRequest);
  }
}
