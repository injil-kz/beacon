// ignore_for_file: public_member_api_docs

import 'package:beacon/beacon.dart';
import 'package:beacon/src/presentation/widgets/body_display_widget.dart';
import 'package:beacon/src/presentation/widgets/json_describe_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestView extends StatelessWidget {
  const RequestView({required this.httpCall, super.key});
  final BeaconHttpCall httpCall;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final uri = Uri.parse(httpCall.request.path);
    final titleStyle = textTheme.titleMedium?.copyWith(
      color: Theme.of(context).colorScheme.primary,
    );
    final valueStyle = textTheme.titleMedium?.copyWith(
      color: Colors.grey[400],
    );
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: BackButton(),
        middle: Text('Request'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      if (uri.scheme == 'https')
                        WidgetSpan(
                          child: Icon(
                            Icons.lock_outline,
                            color: 200.color,
                            size: 20,
                          ),
                        )
                      else
                        WidgetSpan(
                          child: Icon(
                            Icons.lock_open_outlined,
                            color: 500.color,
                            size: 20,
                          ),
                        ),
                      TextSpan(
                        text: ' ${uri.host}',
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'ID: ',
                        style: titleStyle,
                      ),
                      TextSpan(
                        text: httpCall.xRequestId,
                        style: textTheme.headlineSmall?.copyWith(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Method: ',
                        style: titleStyle,
                      ),
                      TextSpan(
                        text: httpCall.request.method.name,
                        style: textTheme.headlineSmall?.copyWith(
                          color: httpCall.request.method.color,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Endpoint: ',
                        style: titleStyle,
                      ),
                      TextSpan(
                        text: ' ${uri.path}',
                        style: valueStyle,
                      ),
                    ],
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'TimeStamp: ',
                        style: titleStyle,
                      ),
                      TextSpan(
                        text: DateTime.fromMillisecondsSinceEpoch(httpCall.request.timestampInMilliseconds.toInt())
                            .toIso8601String(),
                        style: valueStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Connection Timeout: ',
                        style: titleStyle,
                      ),
                      TextSpan(
                        text: '${httpCall.request.connectionTimeout} ms',
                        style: valueStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Receive Timeout: ',
                        style: titleStyle,
                      ),
                      TextSpan(
                        text: '${httpCall.request.receiveTimeout} ms',
                        style: valueStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Headers',
                  style: titleStyle,
                ),
                const SizedBox(height: 10),
                if (httpCall.request.headers == null || httpCall.request.headers!.isEmpty)
                  Text(
                    'Headers are empty',
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[400],
                    ),
                  )
                else
                  JsonDescribeWidget(json: httpCall.request.headers!),
                const SizedBox(height: 15),
                Text(
                  'Query Parameters',
                  style: titleStyle,
                ),
                const SizedBox(height: 10),
                if (httpCall.request.query == null || httpCall.request.query!.isEmpty)
                  Text(
                    'Query parameters are empty',
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[400],
                    ),
                  )
                else
                  JsonDescribeWidget(json: httpCall.request.query!),
                const SizedBox(height: 15),
                Text(
                  'Body',
                  style: titleStyle,
                ),
                const SizedBox(height: 10),
                BodyDisplayWidget(
                  body: httpCall.request.body,
                  contentType: httpCall.request.headers?['content-type'] as String? ?? 'application/json',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
