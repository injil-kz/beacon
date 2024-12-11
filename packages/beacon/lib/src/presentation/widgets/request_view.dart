import 'package:beacon/beacon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RequestView extends StatelessWidget {
  const RequestView({required this.httpCall, super.key});
  final BeaconHttpCall httpCall;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Method'),
          subtitle: Text(httpCall.request.method.name),
        ),
      ],
    );
  }
}
