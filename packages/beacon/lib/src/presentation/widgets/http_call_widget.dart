// ignore_for_file: public_member_api_docs

import 'package:beacon/beacon.dart';
import 'package:beacon/src/presentation/call_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 21,
            fit: FlexFit.tight,
            child: Text.rich(
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
                    style: textTheme.labelMedium?.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (httpCall.response != null) ...[
            const Spacer(flex: 3),
            Flexible(
              flex: 4,
              child: Text(
                _formatMilliseconds(httpCall.response?.responseTimeInMilliseconds?.toInt() ?? 0),
                style: textTheme.bodySmall?.copyWith(
                  color: httpCall.response?.statusCode.color,
                ),
              ),
            ),
            const Spacer(flex: 5),
            Flexible(
              flex: 4,
              child: Text(
                _formatBytes(httpCall.response?.size ?? 0),
                style: textTheme.bodySmall?.copyWith(
                  color: httpCall.response?.statusCode.color,
                ),
              ),
            ),
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

String _formatBytes(int bytes) {
  if (bytes <= 0) return '0 B';
  const List<String> units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  final int digitGroups = (math.log(bytes) / math.log(1024)).floor();
  return '${(bytes / math.pow(1024, digitGroups)).toStringAsFixed(2)} ${units[digitGroups]}';
}

String _formatMilliseconds(int milliseconds) {
  if (milliseconds <= 0) return '0 ms';
  const List<String> units = ['ms', 's', 'm', 'h'];
  final int digitGroups = (math.log(milliseconds) / math.log(1000)).floor();
  return '${(milliseconds / math.pow(1000, digitGroups)).toStringAsFixed(1)} ${units[digitGroups]}';
}
