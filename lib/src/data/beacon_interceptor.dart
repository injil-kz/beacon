import 'package:beacon/src/domain/repository/beacon_repository.dart';

class BeaconInterceptor {
  const BeaconInterceptor({required BeaconRepository beaconRepository}) : _beaconRepository = beaconRepository;

  final BeaconRepository _beaconRepository;
}
