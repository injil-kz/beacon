import 'package:beacon/beacon.dart';
import 'package:beacon/src/domain/repository/beacon_repository.dart';
import 'package:beacon/src/presentation/beacon_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class BeaconConfiguration {
  // FUCKING [NavigatorState] DOESN'T ALLOW TO WORK WITH HISTORY
  bool _isOpen = false;
  // Cheking if user is on Beacon
  bool get userOnBeaconScreen => _isOpen;
  // Setting user on Beacon
  void setUserOnBeaconScreen(bool value) {
    _isOpen = value;
  }

  /// A repository for managing beacon-related data and operations.
  BeaconRepository get repo;

  /// A route that navigates to the BeaconScreen using a CupertinoPageRoute.
  PageRoute<void> get beaconRoute => CupertinoPageRoute<void>(
        builder: (context) => BeaconScreeen(),
      );
}

class BeaconConfigurationProvider extends InheritedWidget {
  final BeaconConfiguration configuration;

  const BeaconConfigurationProvider({
    Key? key,
    required this.configuration,
    required Widget child,
  }) : super(key: key, child: child);

  static BeaconConfigurationProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BeaconConfigurationProvider>();
  }

  @override
  bool updateShouldNotify(BeaconConfigurationProvider oldWidget) {
    return configuration != oldWidget.configuration;
  }
}
