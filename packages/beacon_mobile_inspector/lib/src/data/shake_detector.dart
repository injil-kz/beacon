import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math';

class ShakeDetector {
  final void Function() onShake;
  final double shakeThresholdGravity;
  final int minTimeBetweenShakes;
  final int debounceTime;

  int _lastShakeTimestamp = 0;
  Timer? _debounceTimer;

  StreamSubscription<AccelerometerEvent>? _subscription;

  ShakeDetector({
    required this.onShake,
    this.shakeThresholdGravity = 1.2,
    this.minTimeBetweenShakes = 500,
    this.debounceTime = 1000,
  });

  void startListening() {
    _subscription = accelerometerEventStream(samplingPeriod: SensorInterval.gameInterval).listen(_onShakeDetected);
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  // Thanks to my engineering degree for this one.
  void _onShakeDetected(AccelerometerEvent event) {
    const double standardGravity = 9.80665;
    final double normalizedX = event.x / standardGravity;
    final double normalizedY = event.y / standardGravity;
    final double normalizedZ = event.z / standardGravity;

    // Calculate the Euclidean norm of the acceleration vector.
    final double resultantAcceleration = sqrt(pow(normalizedX, 2) + pow(normalizedY, 2) + pow(normalizedZ, 2));

    if (resultantAcceleration > shakeThresholdGravity) {
      final int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;

      // Throttle shake events to prevent excessive triggering.
      if (_lastShakeTimestamp + minTimeBetweenShakes > currentTimeMillis) {
        return;
      }

      _lastShakeTimestamp = currentTimeMillis;

      // Debounce the shake event to ensure stability.
      _debounceTimer?.cancel();
      _debounceTimer = Timer(Duration(milliseconds: debounceTime), () {
        onShake.call();
      });
    }
  }
}
