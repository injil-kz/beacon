// ignore_for_file: public_member_api_docs

import 'package:injil_beacon/injil_beacon.dart';
import 'package:injil_beacon/src/config/theme.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({required this.httpCall, super.key});
  final BeaconHttpCall httpCall;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final uri = Uri.parse(httpCall.request.path);
    final titleStyle = textTheme.titleLarge?.copyWith(
      color: Theme.of(context).colorScheme.primary,
    );
    final valueStyle = textTheme.titleLarge?.copyWith(
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
              title: Text('Error'),
            ),
            httpCall.error == null
                ? SliverFillRemaining(
                    child: Center(
                      child: httpCall.response != null
                          ? Text(
                              'No errors',
                              style: titleStyle,
                            )
                          : const CircularProgressIndicator.adaptive(),
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
                                          size: 30,
                                        ),
                                      )
                                    else
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.lock_open_outlined,
                                          color: 500.color,
                                          size: 30,
                                        ),
                                      ),
                                    TextSpan(
                                      text: ' ${uri.host}',
                                      style: textTheme.titleLarge?.copyWith(
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
                                      text: 'Status Code: ',
                                      style: titleStyle,
                                    ),
                                    TextSpan(
                                      text: '${httpCall.error!.statusCode}',
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
                                      text: 'Message: ',
                                      style: titleStyle,
                                    ),
                                    TextSpan(
                                      text: httpCall.error!.message,
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
                                      text: 'Details: ',
                                      style: titleStyle,
                                    ),
                                    TextSpan(
                                      text: '${httpCall.error!.details}',
                                      style: valueStyle,
                                    ),
                                  ],
                                ),
                              ),
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
