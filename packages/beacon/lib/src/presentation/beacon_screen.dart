// ignore_for_file: public_member_api_docs

import 'package:beacon/beacon.dart';
import 'package:beacon/src/presentation/widgets/http_call_widget.dart';
import 'package:beacon/src/presentation/widgets/injil_theme_wrapper.dart';
import 'package:beacon/src/presentation/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
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
    return InjThemeWrapper(
      child: Scaffold(
        appBar: const CupertinoNavigationBar(
          middle: Text.rich(
            TextSpan(
              children: [
                WidgetSpan(child: BeaconLogo(), alignment: PlaceholderAlignment.middle),
                TextSpan(
                  text: ' Beacon',
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
          leading: BackButton(),
        ),
        body: SafeArea(
          child: Material(
            child: FutureBuilder<List<BeaconHttpCall>>(
              future: _beaconConfig.repo.getHttpCalls(),
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
        ),
      ),
    );
  }
}
