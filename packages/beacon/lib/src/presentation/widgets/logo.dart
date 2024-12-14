// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

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
