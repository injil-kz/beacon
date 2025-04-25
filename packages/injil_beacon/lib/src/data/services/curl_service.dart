import 'dart:convert';

import 'package:injil_beacon/injil_beacon.dart';

class CurlService {
  static String cURLFormat(BeaconHttpRequest request) {
    final effectiveHeaders = {...?request.headers};
    String bodyString = '';
    String? contentType = effectiveHeaders.entries
        .firstWhere((entry) => entry.key.toLowerCase() == 'content-type', orElse: () => const MapEntry('', ''))
        .value;

    if (request.body != null) {
      if (contentType == 'application/x-www-form-urlencoded') {
        if (request.body is Map<String, dynamic>) {
          final formData = (request.body as Map<String, dynamic>)
              .entries
              .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
              .join('&');
          // Use single quotes for the data to handle potential special characters in values
          bodyString = "-d '$formData'";
        } else {
          // Fallback for non-map bodies with this content type, though less common
          bodyString = "-d '${request.body.toString()}'";
        }
        // Ensure the Content-Type header is explicitly set
        effectiveHeaders['Content-Type'] = 'application/x-www-form-urlencoded';
      } else if (request.body is String) {
        // Escape double quotes within the string body if necessary.
        // Enclose the string body in double quotes.
        bodyString = '-d "${request.body.replaceAll('"', '\\"')}"';
      } else {
        // Encode non-string bodies (like Map or List) as JSON by default.
        // Enclose the entire JSON string in single quotes to prevent shell interpretation issues.
        String jsonBody = jsonEncode(request.body);
        // Escape single quotes within the JSON string if any, replace with '\''
        jsonBody = jsonBody.replaceAll("'", r"'\''");
        bodyString = "-d '$jsonBody'";

        // Automatically add Content-Type header if body is present and header is missing or not form-urlencoded
        if (!effectiveHeaders.keys.any((k) => k.toLowerCase() == 'content-type')) {
          effectiveHeaders['Content-Type'] = 'application/json';
        }
      }
    }

    // Use single quotes for header values to handle potential special characters
    final headersString = effectiveHeaders.entries.map((e) => "-H '${e.key}: ${e.value}'").join(' ');

    final pathWithQuery = _pathWithQueryParameters(request);
    final methodString = _requestInCurl(request);

    // Construct the final cURL command string
    final parts = ['curl', '-X', methodString];
    if (headersString.isNotEmpty) {
      parts.add(headersString);
    }
    if (bodyString.isNotEmpty) {
      parts.add(bodyString);
    }
    // Enclose the URL in single quotes to prevent issues with '&' in the shell
    parts.add("'$pathWithQuery'");

    return parts.join(' ');
  }

  static String _requestInCurl(BeaconHttpRequest request) => request.method.name;

  static String _pathWithQueryParameters(BeaconHttpRequest request) {
    final queryRaw = _queryInRaw(request);
    // Ensure the base path doesn't already end with '?' before appending query parameters
    final separator = request.path.contains('?') ? '&' : '?';
    return '${request.path}${queryRaw.isNotEmpty ? '$separator$queryRaw' : ''}';
  }

  static String _queryInRaw(BeaconHttpRequest request) =>
      request.query?.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}').join('&') ??
      '';
}
