// ignore_for_file: public_member_api_docs, use_build_context_synchronously

import 'dart:convert';

import 'package:beacon/src/presentation/widgets/injil_theme_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonDescribeWidget extends StatelessWidget {
  const JsonDescribeWidget({required this.json, super.key});
  final Map<String, dynamic> json;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    return Material(
      child: InkWell(
        onLongPress: () async {
          await Clipboard.setData(ClipboardData(text: jsonEncode(json)));
          BeaconToastNotifier.of(context)?.addToast(
            'Copied to Clipboard',
            BeaconToastType.success,
          );
        },
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: json.length,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemBuilder: (context, index) {
            final header = json.entries.elementAt(index);
            return Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: header.key,
                    style: textStyle,
                  ),
                  TextSpan(
                    text: ': ',
                    style: textStyle,
                  ),
                  TextSpan(
                    text: header.value.toString(),
                    style: textStyle?.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
      ),
    );
  }
}
