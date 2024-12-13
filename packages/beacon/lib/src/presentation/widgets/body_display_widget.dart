// ignore_for_file: public_member_api_docs, inference_failure_on_instance_creation

import 'package:beacon/src/presentation/see_full_body_screen.dart';
import 'package:beacon/src/presentation/widgets/json_describe_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyDisplayWidget extends StatelessWidget {
  const BodyDisplayWidget({super.key, this.body, this.allowFullDisplay = false});
  final dynamic body;
  final bool allowFullDisplay;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.titleLarge;
    if (body == null) {
      return Text(
        'Body is empty',
        style: textStyle,
      );
    } else if (body is Map) {
      final hasJsonObjectWrapperinTree = context.findAncestorWidgetOfExactType<_JsonObjectWrapper>() != null;
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
            _JsonObjectWrapper(
              child: JsonDescribeWidget(json: body as Map<String, dynamic>),
            ),
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
              return _JsonObjectWrapper(child: BodyDisplayWidget(body: item));
            },
          ),
          if (length > 3 && !allowFullDisplay) ...[
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => SeeFullBodyScreen(body: body),
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
}

class _JsonObjectWrapper extends StatelessWidget {
  const _JsonObjectWrapper({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.33),
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
