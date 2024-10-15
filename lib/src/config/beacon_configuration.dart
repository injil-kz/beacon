import 'package:beacon/src/data/repository/beacon_repository_impl.dart';
import 'package:beacon/src/domain/repository/beacon_repository.dart';

class BeaconConfiguration {
  BeaconConfiguration({BeaconRepository? beaconRepository})
      : _beaconRepository = beaconRepository ?? BeaconRepositoryImpl.instance;

  final BeaconRepository _beaconRepository;

  BeaconRepository get beaconRepository => _beaconRepository;
}
