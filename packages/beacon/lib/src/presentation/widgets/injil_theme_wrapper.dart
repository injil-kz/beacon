// ignore_for_file: public_member_api_docs, must_be_immutable, library_private_types_in_public_api

import 'dart:async';

import 'package:beacon/src/config/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InjThemeWrapper extends StatelessWidget {
  const InjThemeWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BeaconToastProvider(
      child: Theme(
        data: injilTheme,
        child: CupertinoTheme(
          data: injilCupertinoTheme,
          child: Stack(
            children: [
              child,
              Positioned(
                top: MediaQuery.of(context).viewInsets.top + kMinInteractiveDimensionCupertino,
                right: 8,
                child: _ToastBuilder(child: child),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToastBuilder extends StatelessWidget {
  const _ToastBuilder({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final notifier = BeaconToastNotifier.of(context);
    if (notifier == null) {
      return const SizedBox();
    }
    final background = notifier.type == BeaconToastType.success
        ? Colors.green
        : notifier.type == BeaconToastType.error
            ? Colors.red
            : notifier.type == BeaconToastType.warning
                ? Colors.orange
                : Colors.blue;
    return AnimatedOpacity(
      opacity: notifier.show ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 777),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            notifier.data ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: background.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}

enum BeaconToastType {
  success,
  error,
  warning,
  info,
}

class BeaconToastNotifier extends InheritedNotifier<_BeaconToastNotifierState> {
  const BeaconToastNotifier({
    required super.child,
    required _BeaconToastNotifierState notifier,
    super.key,
  }) : super(notifier: notifier);

  static _BeaconToastNotifierState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BeaconToastNotifier>()?.notifier;
  }
}

class _BeaconToastNotifierState extends ChangeNotifier {
  String? data;
  BeaconToastType? type;
  bool show = false;

  void addToast(String data, BeaconToastType type) {
    this.data = data;
    this.type = type;
    show = true;
    notifyListeners();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        show = false;
        notifyListeners();
      },
    );
  }
}

class BeaconToastProvider extends StatefulWidget {
  const BeaconToastProvider({required this.child, super.key});

  final Widget child;

  @override
  _BeaconToastProviderState createState() => _BeaconToastProviderState();
}

class _BeaconToastProviderState extends State<BeaconToastProvider> {
  final _BeaconToastNotifierState _notifier = _BeaconToastNotifierState();

  @override
  Widget build(BuildContext context) {
    return BeaconToastNotifier(
      notifier: _notifier,
      child: widget.child,
    );
  }
}
