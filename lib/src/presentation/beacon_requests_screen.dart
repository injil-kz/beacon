import 'dart:async';

import 'package:beacon/src/config/beacon_configuration.dart';
import 'package:beacon/src/domain/models/http_request.dart';
import 'package:beacon/src/presentation/controllers/beacon_http_requests_controller.dart';
import 'package:flutter/material.dart';

class BeaconRequestsScreen extends StatefulWidget {
  const BeaconRequestsScreen({super.key, required this.configuration});

  final BeaconConfiguration configuration;

  @override
  State<BeaconRequestsScreen> createState() => _BeaconRequestsScreenState();
}

class _BeaconRequestsScreenState extends State<BeaconRequestsScreen> {
  late final BeaconHttpRequestsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BeaconHttpRequestsController(
      controller: StreamController(),
      beaconRepository: widget.configuration.beaconRepository,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beacon')),
      body: StreamBuilder<List<HttpRequest>>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Offstage();
          }
          final requests = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: requests.length,
                itemBuilder: (context, index) => const ListTile(),
                separatorBuilder: (context, index) => const SizedBox(height: 12),
              ),
            ],
          );
        },
      ),
    );
  }
}
