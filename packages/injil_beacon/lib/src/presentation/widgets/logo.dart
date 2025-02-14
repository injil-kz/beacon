// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

extension StringExt on String {
  String get capitalize => this[0].toUpperCase() + this.substring(1);
  Color get toColor => Color(int.parse('0xff${this.replaceAll('#', '').trim()}'));
}

extension ColorExt on Color {
  String get toHex => '#${value.toRadixString(16).substring(2)}';
}

class BeaconLogo extends StatelessWidget {
  const BeaconLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/beacon_logo.png',
      package: 'beacon',
      height: 35,
      width: 35,
      cacheHeight: 35,
      cacheWidth: 35,
    );
  }
}
