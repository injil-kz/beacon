import 'package:beacon/beacon.dart';
import 'package:beacon/src/domain/repository/beacon_repository.dart';
import 'package:beacon/src/presentation/beacon_screen.dart';
import 'package:flutter/cupertino.dart';

abstract class BeaconConfiguration {
  BeaconRepository get repo;

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
