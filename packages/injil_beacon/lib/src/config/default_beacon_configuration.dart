import 'package:injil_beacon/src/data/repository/in_memory_beacon_repository.dart';
import 'package:injil_beacon/src/domain/beacon_configuration.dart';
import 'package:injil_beacon/src/domain/repository/beacon_repository.dart';

/// A configuration class that provides access to beacon-related data and operations.
class DefaultBeaconConfiguration extends BeaconConfiguration {
  /// A factory constructor that returns the singleton instance of the `BeaconConfiguration` class.
  factory DefaultBeaconConfiguration() {
    return _instance;
  }
  DefaultBeaconConfiguration._privateConstructor({
    required this.repo,
  });

  static final DefaultBeaconConfiguration _instance = DefaultBeaconConfiguration._privateConstructor(
    repo: InMemoryBeaconRepository(),
  );

  /// A repository that provides access to beacon-related data and operations.
  final BeaconRepository repo;
}
