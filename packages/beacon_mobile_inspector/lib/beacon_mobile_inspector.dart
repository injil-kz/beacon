import 'package:beacon/beacon.dart';
import 'package:beacon_mobile_inspector/src/data/shake_detector.dart';
import 'package:flutter/material.dart';

/// A Calculator.
class BeaconMobileInspector {
  late final ShakeDetector shakeDetector;
  final BeaconConfiguration configuration;
  final GlobalKey<NavigatorState> navigatorKey;
  final bool shakeToOpen;

  BeaconMobileInspector({
    required this.configuration,
    required this.navigatorKey,
    this.shakeToOpen = true,
  });

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    shakeDetector = ShakeDetector(
      onShake: _onShake,
    );
    if (shakeToOpen) {
      shakeDetector.startListening();
    }
  }

  void _onShake() {
    if (configuration.userOnBeaconScreen) {
      return;
    }

    final context = navigatorKey.currentContext;

    if (context != null) {
      Navigator.of(navigatorKey.currentContext!).push(configuration.beaconRoute);
      configuration.setUserOnBeaconScreen(true);
      return;
    }
  }

  void dispose() {
    shakeDetector.stopListening();
  }
}
