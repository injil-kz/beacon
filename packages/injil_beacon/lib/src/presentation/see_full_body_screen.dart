// ignore_for_file: public_member_api_docs

import 'package:injil_beacon/src/presentation/widgets/body_display_widget.dart';
import 'package:injil_beacon/src/presentation/widgets/injil_theme_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeeFullBodyScreen extends StatelessWidget {
  const SeeFullBodyScreen({
    required this.contentType,
    super.key,
    this.body,
  });
  final dynamic body;
  final String contentType;

  @override
  Widget build(BuildContext context) {
    return InjThemeWrapper(
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          leading: BackButton(),
          middle: Text('Body'),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: BodyDisplayWidget(
                body: body,
                allowFullDisplay: true,
                contentType: contentType,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
