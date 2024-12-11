import 'package:beacon/beacon.dart';
import 'package:example/service/navigation.dart';
import 'package:flutter/material.dart';

void main() {
  final configuration = BeaconConfiguration();
  runApp(MyApp(configuration: configuration));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.configuration});

  final BeaconConfiguration configuration;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router.config(),
    );
  }
}
