// ignore_for_file: public_member_api_docs

import 'package:injil_beacon/injil_beacon.dart';
import 'package:injil_beacon/src/config/theme.dart';
import 'package:injil_beacon/src/presentation/widgets/body_display_widget.dart';
import 'package:injil_beacon/src/presentation/widgets/json_describe_widget.dart';
import 'package:flutter/material.dart';

class ResponseView extends StatelessWidget {
  const ResponseView({required this.httpCall, super.key});
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
    return SafeArea(
      top: true,
      bottom: true,
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: true,
              leading: BackButton(color: injilTheme.colorScheme.primary),
              title: Text('Response'),
            ),
            httpCall.response == null
                ? httpCall.error != null
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'Error while fetching response',
                            style: textTheme.headlineMedium?.copyWith(
                              color: Colors.red[200],
                            ),
                          ),
                        ),
                      )
                    : SliverFillRemaining(
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      )
                : SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Padding(
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
                              const SizedBox(height: 15),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'ID: ',
                                      style: titleStyle,
                                    ),
                                    TextSpan(
                                      text: httpCall.xRequestId,
                                      style: titleStyle?.copyWith(
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
                                      text: 'Status: ',
                                      style: titleStyle,
                                    ),
                                    TextSpan(
                                      text: httpCall.response!.statusCode.toString(),
                                      style: titleStyle?.copyWith(
                                        color: httpCall.response!.statusCode.color,
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
                                      text: DateTime.fromMillisecondsSinceEpoch(
                                              httpCall.response!.timestampInMilliseconds.toInt())
                                          .toString(),
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
                                      text: 'Response Time: ',
                                      style: titleStyle,
                                    ),
                                    TextSpan(
                                      text: '${httpCall.response!.responseTimeInMilliseconds} ms',
                                      style: valueStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Body',
                                style: titleStyle,
                              ),
                              const SizedBox(height: 10),
                              BodyDisplayWidget(
                                body: httpCall.response!.body,
                                contentType: (httpCall.response!.headers?['content-type'] as List<String?>)[0] ?? '',
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Headers',
                                style: titleStyle,
                              ),
                              const SizedBox(height: 10),
                              if (httpCall.response!.headers == null || httpCall.response!.headers!.isEmpty)
                                Text(
                                  'Headers are empty',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[400],
                                  ),
                                )
                              else
                                JsonDescribeWidget(json: httpCall.response!.headers!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
