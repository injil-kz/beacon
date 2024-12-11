import 'package:beacon/src/data/repository/in_memory_beacon_repository.dart';
import 'package:beacon/src/domain/repository/beacon_repository.dart';

/// A configuration class that provides access to beacon-related data and operations.
class BeaconConfiguration {
  /// A factory constructor that returns the singleton instance of the `BeaconConfiguration` class.
  factory BeaconConfiguration() {
    return _instance;
  }
  BeaconConfiguration._privateConstructor({
    required this.repo,
  });

  static final BeaconConfiguration _instance = BeaconConfiguration._privateConstructor(
    repo: InMemoryBeaconRepository(),
  );

  /// A repository that provides access to beacon-related data and operations.
  final BeaconRepository repo;
}
