import 'package:beacon/beacon.dart';
import 'package:beacon/src/presentation/widgets/cookie_view.dart';
import 'package:beacon/src/presentation/widgets/error_view.dart';
import 'package:beacon/src/presentation/widgets/injil_theme_wrapper.dart';
import 'package:beacon/src/presentation/widgets/request_view.dart';
import 'package:beacon/src/presentation/widgets/response_view.dart';
import 'package:flutter/cupertino.dart';
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
    return InjThemeWrapper(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_upward_outlined),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_downward_outlined),
              label: 'Response',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.error_outline),
              label: 'Error',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cookie),
              label: 'Cookies',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return Material(
                child: RequestView(
                  httpCall: widget.httpCall,
                ),
              );
            case 1:
              return Material(
                child: ResponseView(
                  httpCall: widget.httpCall,
                ),
              );
            case 2:
              return Material(
                child: ErrorView(
                  httpCall: widget.httpCall,
                ),
              );
            case 3:
              return Material(
                child: CookieView(
                  httpCall: widget.httpCall,
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
