import 'package:beacon/beacon.dart';
import 'package:beacon/src/config/theme.dart';
import 'package:beacon/src/presentation/widgets/request_view.dart';
import 'package:flutter/material.dart';

class CallDetailsScreen extends StatefulWidget {
  final BeaconHttpCall httpCall;
  const CallDetailsScreen({
    required this.httpCall,
    super.key,
  });

  @override
  State<CallDetailsScreen> createState() => _CallDetailsScreenState();
}

class _CallDetailsScreenState extends State<CallDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: injilTheme,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Call Details'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Request'),
                Tab(text: 'Response'),
                Tab(text: 'Cookie'),
                Tab(text: 'Error'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: RequestView(
                  httpCall: widget.httpCall,
                ),
              ),
              const Center(child: Text('Response View')),
              const Center(child: Text('Cookie View')),
              const Center(child: Text('Error View')),
            ],
          ),
        ),
      ),
    );
  }
}
