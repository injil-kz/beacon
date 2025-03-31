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
    print(requestFramePen('╔════════════════════════ HTTP Request ════════════════════════'));
    print(requestFramePen('║ Method: ') + request.method.pen(request.method.name.toString()));
    print(requestFramePen('║ URL: ') + urlPen(request.path));
    _mapPrinter(
      name: 'Headers',
      map: request.headers,
      framePen: requestFramePen,
      keyPen: headerNamePen,
      valuePen: headerValuePen,
    );
    _mapPrinter(
      name: 'Query Parameters',
      map: request.query,
      framePen: requestFramePen,
      keyPen: bodyNamePen,
      valuePen: bodyValuePen,
    );
    _mapPrinter(
      name: 'Body',
      map: request.body,
      framePen: requestFramePen,
      keyPen: bodyNamePen,
      valuePen: bodyValuePen,
    );
    print(requestFramePen('╚══════════════════════════════════════════════════════════════'));
  }

  static void logResponse(BeaconHttpResponse response) {
    print(responseFramePen('╔════════════════════════ HTTP Response ═══════════════════════'));
    print(responseFramePen('║ Status Code: ') + response.statusCode.pen(response.statusCode));
    print(responseFramePen(
        '║ Timestamp: ${DateTime.fromMillisecondsSinceEpoch(response.timestampInMilliseconds.toInt()).toIso8601String()}'));
    print(responseFramePen('║ ResponseTime: ${response.responseTimeInMilliseconds} (ms)'));
    _mapPrinter(
      name: 'Headers',
      map: response.headers,
      framePen: responseFramePen,
      keyPen: headerNamePen,
      valuePen: headerValuePen,
    );
    _mapPrinter(
      name: 'Body',
      map: response.body,
      framePen: responseFramePen,
      keyPen: bodyNamePen,
      valuePen: bodyValuePen,
    );
    print(responseFramePen('╚══════════════════════════════════════════════════════════════'));
  }

  static void logError(dynamic error) {
    print(errorFramePen('╔════════════════════════ HTTP Error ══════════════════════════'));
    print('║ Error: ${error}');
    print(errorFramePen('╚══════════════════════════════════════════════════════════════'));
  }

  static void _mapPrinter({
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
        print(framePen('║ $name:'));
      else
        print(framePen('║ │ ') + keyPen(name) + framePen(':'));
    } else {}
    if (hasFrame) print(framePen('║ ┌──────────────────────────────────────────────────'));
    if (map != null && map.isNotEmpty)
      map.forEach((key, value) {
        if (value is Map) {
          _mapPrinter(
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
          print(framePen('║ │ ' * depth) + keyPen(key) + ':');
          for (final subItem in value) {
            if (subItem is Map) {
              _mapPrinter(
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
              print(framePen('║ │ ' * (depth + 1)) + valuePen(subItem.toString()));
            }
          }

          return;
        }

        print(framePen('║ │ ' * depth) + keyPen(key) + ': ' + valuePen(value.toString()));
      });
    else
      print(framePen('║ │ ' * depth) + '<empty>');
    if (hasFrame)
      print(framePen('║ └──────────────────────────────────────────────────'));
    else
      print(framePen('║ │ ' * depth));
  }
}
