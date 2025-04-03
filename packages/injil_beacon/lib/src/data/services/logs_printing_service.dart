import 'dart:developer';

import 'package:ansicolor/ansicolor.dart' show AnsiPen;
import 'package:injil_beacon/injil_beacon.dart';

class LogsPrintingService {
  static final AnsiPen requestFramePen = AnsiPen()..rgb();
  static final AnsiPen responseFramePen = AnsiPen()..rgb();
  static final AnsiPen errorFramePen = AnsiPen()..red();
  static final AnsiPen urlPen = AnsiPen()..green();
  static final AnsiPen headerNamePen = AnsiPen()..yellow();
  static final AnsiPen headerValuePen = AnsiPen()..white();
  static final AnsiPen bodyNamePen = AnsiPen()..magenta();
  static final AnsiPen bodyValuePen = AnsiPen()..white();

  static void logRequest(BeaconHttpRequest request) {
    printLogLine(requestFramePen('╔════════════════════════ HTTP Request ════════════════════════'));
    printLogLine(requestFramePen('║ Method: ') + request.method.pen(request.method.name.toString()));
    printLogLine(requestFramePen('║ URL: ') + urlPen(request.path));
    _mapprinter(
      name: 'Headers',
      map: request.headers,
      framePen: requestFramePen,
      keyPen: headerNamePen,
      valuePen: headerValuePen,
    );
    _mapprinter(
      name: 'Query Parameters',
      map: request.query,
      framePen: requestFramePen,
      keyPen: bodyNamePen,
      valuePen: bodyValuePen,
    );

    if (request.body is Map) {
      _mapprinter(
        name: 'Body',
        map: request.body,
        framePen: responseFramePen,
        keyPen: bodyNamePen,
        valuePen: bodyValuePen,
      );
    } else if (request.body is List) {
      _listprinter(
        name: 'Body',
        list: request.body,
        framePen: responseFramePen,
        keyPen: bodyNamePen,
        valuePen: bodyValuePen,
      );
    } else {
      printLogLine(responseFramePen('║ Body:'));
      printLogLine(responseFramePen('║ ┌──────────────────────────────────────────────────'));
      printLogLine(responseFramePen('║ ' + request.body.toString()));
      printLogLine(responseFramePen('║ └──────────────────────────────────────────────────'));
    }

    printLogLine(requestFramePen('╚══════════════════════════════════════════════════════════════'));
  }

  static void logResponse(BeaconHttpResponse response) {
    printLogLine(responseFramePen('╔════════════════════════ HTTP Response ═══════════════════════'));
    printLogLine(responseFramePen('║ URL: ') + response.url);
    printLogLine(responseFramePen('║ Status Code: ') + response.statusCode.pen(response.statusCode));
    printLogLine(responseFramePen(
        '║ Timestamp: ${DateTime.fromMillisecondsSinceEpoch(response.timestampInMilliseconds.toInt()).toIso8601String()}'));
    printLogLine(responseFramePen('║ ResponseTime: ${response.responseTimeInMilliseconds} (ms)'));
    _mapprinter(
      name: 'Headers',
      map: response.headers,
      framePen: responseFramePen,
      keyPen: headerNamePen,
      valuePen: headerValuePen,
    );
    if (response.body is Map) {
      _mapprinter(
        name: 'Body',
        map: response.body,
        framePen: responseFramePen,
        keyPen: bodyNamePen,
        valuePen: bodyValuePen,
      );
    } else if (response.body is List) {
      _listprinter(
        name: 'Body',
        list: response.body,
        framePen: responseFramePen,
        keyPen: bodyNamePen,
        valuePen: bodyValuePen,
      );
    } else {
      printLogLine(responseFramePen('║ Body:'));
      printLogLine(responseFramePen('║ ┌──────────────────────────────────────────────────'));
      printLogLine(responseFramePen('║ ' + response.body.toString()));
      printLogLine(responseFramePen('║ └──────────────────────────────────────────────────'));
    }

    printLogLine(responseFramePen('╚══════════════════════════════════════════════════════════════'));
  }

  static void logError(dynamic error) {
    printLogLine(errorFramePen('╔════════════════════════ HTTP Error ══════════════════════════'));
    printLogLine(errorFramePen('║ Error: ${error}'));
    printLogLine(errorFramePen('╚══════════════════════════════════════════════════════════════'));
  }

  static void _mapprinter({
    required String name,
    Map<String, dynamic>? map,
    required AnsiPen framePen,
    required AnsiPen keyPen,
    required AnsiPen valuePen,
    int depth = 1,
    bool hasFrame = true,
    bool hasTitle = true,
  }) {
    if (hasTitle) {
      if (depth == 1)
        printLogLine(framePen('║ $name:'));
      else
        printLogLine(framePen('║ │ ') + keyPen(name) + framePen(':'));
    } else {}
    if (hasFrame) printLogLine(framePen('║ ┌──────────────────────────────────────────────────'));
    if (map != null && map.isNotEmpty)
      map.forEach((key, value) {
        if (value is Map) {
          _mapprinter(
            name: key,
            map: value as Map<String, dynamic>,
            framePen: framePen,
            keyPen: keyPen,
            valuePen: valuePen,
            depth: depth + 1,
            hasFrame: false,
          );
          return;
        }
        if (value is List) {
          printLogLine(framePen('║ │ ' * depth) + keyPen(key) + ':');
          for (final subItem in value) {
            if (subItem is Map) {
              _mapprinter(
                name: key,
                map: subItem as Map<String, dynamic>,
                framePen: framePen,
                keyPen: keyPen,
                valuePen: valuePen,
                depth: depth + 1,
                hasFrame: false,
                hasTitle: false,
              );
            } else {
              printLogLine(framePen('║ │ ' * (depth + 1)) + valuePen(subItem.toString()));
            }
          }

          return;
        }

        printLogLine(framePen('║ │ ' * depth) + keyPen(key) + ': ' + valuePen(value.toString()));
      });
    else
      printLogLine(framePen('║ │ ' * depth) + '<empty>');
    if (hasFrame)
      printLogLine(framePen('║ └──────────────────────────────────────────────────'));
    else
      printLogLine(framePen('║ │ ' * depth));
  }

  static void _listprinter({
    required String name,
    required List<dynamic> list,
    required AnsiPen framePen,
    required AnsiPen keyPen,
    required AnsiPen valuePen,
  }) {
    printLogLine(framePen('║ $name:'));
    printLogLine(framePen('║ ┌──────────────────────────────────────────────────'));
    for (final subItem in list) {
      if (subItem is Map) {
        _mapprinter(
          name: '',
          map: subItem as Map<String, dynamic>,
          framePen: framePen,
          keyPen: keyPen,
          valuePen: valuePen,
          depth: 1,
          hasFrame: false,
          hasTitle: false,
        );
      } else {
        printLogLine(framePen('║ │ ') + valuePen(subItem.toString()));
      }
    }
    printLogLine(framePen('║ └──────────────────────────────────────────────────'));
  }

  static void printLogLine(String line) => log(line, name: 'Beacon');
}
