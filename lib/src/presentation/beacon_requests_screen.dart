import 'package:flutter/material.dart';

class BeaconRequestsScreen extends StatelessWidget {
  const BeaconRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beacon - список запросов')),
      body: CustomScrollView(),
    );
  }
}
