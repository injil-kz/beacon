// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:beacon/beacon.dart';
import 'package:beacon/src/config/theme.dart';
import 'package:beacon/src/presentation/widgets/http_call_widget.dart';
import 'package:beacon/src/presentation/widgets/injil_theme_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BeaconScreeen extends StatelessWidget {
  const BeaconScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    final _beaconConfig = BeaconConfigurationProvider.of(context)?.configuration;

    return _BeaconView(
      configuration: _beaconConfig!,
    );
  }
}

class _BeaconView extends StatefulWidget {
  final BeaconConfiguration configuration;
  const _BeaconView({required this.configuration});

  @override
  State<_BeaconView> createState() => __BeaconViewState();
}

class __BeaconViewState extends State<_BeaconView> {
  List<BeaconHttpCall> _calls = [];

  List<BeaconHttpCall> get calls => _calls;
  late final StreamSubscription<List<BeaconHttpCall>> _subscription;

  @override
  void initState() {
    _subscription = widget.configuration.repo.httpCalls.listen((httpCalls) {
      _calls.clear();
      _calls.addAll(httpCalls);
      setState(() {});
    });
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _calls.addAll(await widget.configuration.repo.getHttpCalls());
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InjThemeWrapper(
      child: Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Material(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  leading: BackButton(color: injilTheme.colorScheme.primary),
                  title: Text('Beacon'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {},
                    ),
                  ],
                ),
                if (calls.isEmpty)
                  SliverFillRemaining(
                    child: const Center(
                      child: Text('No data'),
                    ),
                  )
                else
                  SliverList.builder(
                    itemCount: calls.length,
                    itemBuilder: (context, index) => HttpCallWidget(
                      httpCall: calls[calls.length - index - 1],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
