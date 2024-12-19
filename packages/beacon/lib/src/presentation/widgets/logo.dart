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

class InjTitle extends StatelessWidget {
  final String title;
  final List<String>? colors;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool selectable;
  final int? maxLines;

  const InjTitle({
    super.key,
    required this.title,
    this.colors,
    this.style,
    this.textAlign,
    this.selectable = false,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    try {
      final LinearGradient gradient = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: (colors == null || colors!.isEmpty ? ["#C9D6FF", "#E2E2E2"] : colors)!
            .cast<String>()
            .map((string) => string.toColor)
            .toList()
            .cast<Color>(),
      );

      return ShaderMask(
        shaderCallback: (bounds) => gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          textDirection: TextDirection.ltr,
        ),
        child: selectable
            ? SelectableText(
                title,
                style: style?.copyWith(color: Colors.white) ?? TextStyle(color: Colors.white),
                textAlign: textAlign,
                maxLines: maxLines ?? 2,
              )
            : Text(
                title,
                style: style?.copyWith(color: Colors.white) ?? TextStyle(color: Colors.white),
                textAlign: textAlign,
                maxLines: maxLines ?? 2,
                overflow: TextOverflow.ellipsis,
              ),
      );
    } catch (_) {
      return Text(
        title,
        maxLines: maxLines,
      );
    }
  }
}
