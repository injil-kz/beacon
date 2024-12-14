// ignore_for_file: public_member_api_docs

import 'package:beacon/beacon.dart';
import 'package:beacon/src/presentation/call_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HttpCallWidget extends StatelessWidget {
  const HttpCallWidget({
    required this.httpCall,
    super.key,
  });
  final BeaconHttpCall httpCall;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final uri = Uri.parse(httpCall.request.path);
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute<void>(
            builder: (context) => CallDetailsScreen(
              httpCall: httpCall,
            ),
          ),
        );
      },
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: httpCall.request.method.name,
              style: textTheme.bodyMedium?.copyWith(
                color: httpCall.request.method.color,
              ),
            ),
            TextSpan(
              text: '  ${uri.path}',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      subtitle: Row(
        children: [
          Text.rich(
            TextSpan(
              children: [
                if (uri.scheme == 'https')
                  WidgetSpan(
                    child: Icon(
                      Icons.lock_outline,
                      color: 200.color,
                      size: 16,
                    ),
                  )
                else
                  WidgetSpan(
                    child: Icon(
                      Icons.lock_open_outlined,
                      color: 500.color,
                      size: 16,
                    ),
                  ),
                TextSpan(
                  text: ' ${uri.host}',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          if (httpCall.response != null) ...[
            const Spacer(),
            Text(
              '${httpCall.response?.responseTimeInMilliseconds?.toInt()} ms',
              style: textTheme.bodySmall?.copyWith(
                color: httpCall.response?.statusCode.color,
              ),
            ),
            const Spacer(),
            Text(
              '${httpCall.response?.size} bytes',
              style: textTheme.bodySmall?.copyWith(
                color: httpCall.response?.statusCode.color,
              ),
            ),
            const Spacer(),
          ],
        ],
      ),
      trailing: httpCall.error != null
          ? Text(
              'Error',
              style: textTheme.bodyMedium?.copyWith(
                color: 500.color,
              ),
            )
          : httpCall.response == null
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : Text(
                  httpCall.response?.statusCode.toString() ?? '',
                  style: textTheme.bodyMedium?.copyWith(
                    color: httpCall.response?.statusCode.color,
                  ),
                ),
    );
  }
}
