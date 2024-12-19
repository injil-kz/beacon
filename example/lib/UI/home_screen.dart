import 'package:auto_route/auto_route.dart';
import 'package:beacon/beacon.dart';
import 'package:example/service/rest_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                RestService().simulateHttpCalls();
              },
              child: const Text('Simulate HTTP Calls'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (_) => BeaconScreeen(),
                  ),
                );
              },
              child: const Text('Go to logs'),
            ),
          ],
        ),
      ),
    );
  }
}
