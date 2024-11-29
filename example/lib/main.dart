import 'package:beacon/beacon.dart';
import 'package:flutter/material.dart';

void main() {
  final configuration = BeaconConfiguration();
  runApp(MyApp(configuration: configuration));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.configuration});

  final BeaconConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
