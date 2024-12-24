// ignore_for_file: public_member_api_docs

import 'package:injil_beacon/injil_beacon.dart';
import 'package:injil_beacon/src/config/theme.dart';
import 'package:injil_beacon/src/presentation/widgets/json_describe_widget.dart';
import 'package:flutter/material.dart';

class CookieView extends StatelessWidget {
  const CookieView({required this.httpCall, super.key});
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
    final requestCookieKey = httpCall.request.headers?.keys.firstWhere(
      (element) => element.toLowerCase() == 'cookie',
      orElse: () => '',
    );
    final requestCookie = httpCall.request.headers?[requestCookieKey] as String?;
    final responseCookieKey = httpCall.response?.headers?.keys.firstWhere(
      (element) => element.toLowerCase() == 'set-cookie',
      orElse: () => '',
    );
    final responseCookie = httpCall.response?.headers?[responseCookieKey] as String?;

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
              title: Text('Cookie'),
            ),
            SliverList(
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
                                style: valueStyle,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text.rich(
                          TextSpan(
                            text: 'Sent Cookie ',
                            children: [
                              TextSpan(
                                text: '(Request)',
                                style: valueStyle,
                              ),
                            ],
                          ),
                          style: titleStyle,
                        ),
                        const SizedBox(height: 10),
                        if (requestCookie != null)
                          JsonDescribeWidget(json: getCookieMap(requestCookie))
                        else
                          Text(
                            'No cookie sent',
                            style: textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[400],
                            ),
                          ),
                        const SizedBox(height: 15),
                        Text.rich(
                          TextSpan(
                            text: 'Set-Cookie ',
                            children: [
                              TextSpan(
                                text: '(Response)',
                                style: valueStyle,
                              ),
                            ],
                          ),
                          style: titleStyle,
                        ),
                        const SizedBox(height: 10),
                        if (responseCookie != null)
                          JsonDescribeWidget(json: getCookieMap(responseCookie))
                        else
                          Text(
                            'Server did not set any cookie',
                            style: textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[400],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> getCookieMap(String raw) {
    final cookieMap = <String, dynamic>{};
    final cookieList = raw.split(';');
    for (final cookie in cookieList) {
      final keyValue = cookie.split('=');
      if (keyValue.length == 2) {
        cookieMap[keyValue[0].trim()] = keyValue[1].trim();
      }
    }
    return cookieMap;
  }
}
