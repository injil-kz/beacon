import 'package:beacon/beacon.dart';
import 'package:beacon_mobile_inspector/beacon_mobile_inspector.dart';
import 'package:example/service/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  final configuration = DefaultBeaconConfiguration();
  final router = AppRouter();

  /// Provide BeaconConfiguration and Inspector to DI if needed
  final beaconInspector = BeaconMobileInspector(
    configuration: configuration,
    navigatorKey: router.navigatorKey,
    shakeToOpen: true,
  );
  beaconInspector.init();
  runApp(
    MyApp(
      configuration: configuration,
      router: router,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.configuration,
    required this.router,
  });

  final BeaconConfiguration configuration;
  final AppRouter router;
  @override
  Widget build(BuildContext context) {
    return BeaconConfigurationProvider(
      configuration: configuration,
      child: MaterialApp.router(
        routerConfig: router.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
