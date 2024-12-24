// ignore_for_file: public_member_api_docs, inference_failure_on_instance_creation

import 'dart:typed_data';

import 'package:injil_beacon/src/domain/models/content_type.dart';
import 'package:injil_beacon/src/presentation/see_full_body_screen.dart';
import 'package:injil_beacon/src/presentation/widgets/json_describe_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyDisplayWidget extends StatelessWidget {
  const BodyDisplayWidget({
    required this.contentType,
    super.key,
    this.body,
    this.allowFullDisplay = false,
  });
  final dynamic body;
  final String contentType;
  final bool allowFullDisplay;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.titleMedium;

    if (body == null) {
      return Text(
        'Body is empty',
        style: textStyle,
      );
    }

    if (contentType.contains(BeaconContentType.applicationJson.header)) {
      if (body is Map) {
        if ((body as Map).isEmpty) {
          return Text(
            'Empty JSON Object',
            style: textStyle,
          );
        }
        final hasJsonObjectWrapperinTree = context.findAncestorWidgetOfExactType<CopyAbleElement>() != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'JSON Object',
              style: textStyle,
            ),
            const SizedBox(height: 5),
            if (hasJsonObjectWrapperinTree)
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: JsonDescribeWidget(json: body as Map<String, dynamic>),
              )
            else
              JsonDescribeWidget(json: body as Map<String, dynamic>),
          ],
        );
      } else if (body is String || body is num) {
        return Text(body.toString());
      } else if (body is List) {
        final length = (body as List).length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List of items',
              style: textStyle,
            ),
            const SizedBox(height: 5),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: length > 3 && !allowFullDisplay ? 3 : length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                // ignore: avoid_dynamic_calls
                final item = body[index];
                return BodyDisplayWidget(
                  body: item,
                  contentType: contentType,
                );
              },
            ),
            if (length > 3 && !allowFullDisplay) ...[
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => SeeFullBodyScreen(
                        body: body,
                        contentType: contentType,
                      ),
                    ),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: '...'),
                      const TextSpan(text: 'and '),
                      TextSpan(
                        text: '${length - 3} more items.',
                      ),
                      TextSpan(
                        text: '  See All',
                        style: textStyle?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                    style: textStyle,
                  ),
                ),
              ),
            ],
          ],
        );
      } else {
        return Text(
          "I can't recognize this type of body, please refer issue to the developer",
          style: textStyle?.copyWith(
            color: Colors.red[200],
          ),
        );
      }
    }
    if (BeaconContentType.isImage(contentType)) {
      if (body is Uint8List) {
        return Image.memory(body as Uint8List);
      } else {
        return Text(
          'Unsupported Image Type\nContent-Type: $contentType\nData-Type: ${body.runtimeType}',
          style: textStyle,
        );
      }
    }

    return Text(
      'Unsupported content type\n$contentType',
      style: textStyle,
    );
  }
}

class CopyAbleElement extends StatelessWidget {
  const CopyAbleElement({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.primary.withAlpha((255 * 0.33).round()),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(padding: const EdgeInsets.only(left: 3), child: child),
        ),
      ),
    );
  }
}
