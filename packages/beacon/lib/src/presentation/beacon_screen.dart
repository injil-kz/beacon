import 'package:beacon/beacon.dart';
import 'package:beacon/src/config/theme.dart';
import 'package:beacon/src/domain/models/http_call.dart';
import 'package:beacon/src/presentation/widgets/http_call_widget.dart';
import 'package:flutter/material.dart';

class BeaconScreen extends StatefulWidget {
  const BeaconScreen({super.key});

  @override
  State<BeaconScreen> createState() => _BeaconScreenState();
}

class _BeaconScreenState extends State<BeaconScreen> {
  final _beaconConfig = BeaconConfiguration();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: injilTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Beacon'),
        ),
        body: StreamBuilder<List<BeaconHttpCall>>(
          stream: _beaconConfig.repo.getHttpCalls().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else if (snapshot.hasData) {
              final httpCalls = snapshot.data;
              if (httpCalls == null || httpCalls.isEmpty) {
                return const Center(
                  child: Text('No data'),
                );
              }
              return ListView.builder(
                itemCount: httpCalls.length,
                itemBuilder: (context, index) => HttpCallWidget(
                  httpCall: httpCalls[index],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
