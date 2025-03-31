// ignore_for_file: public_member_api_docs

import 'dart:ui';
import 'package:ansicolor/ansicolor.dart';

/// Enum representing HTTP methods.
///
/// This enum includes the following HTTP methods:
/// - [GET]: Used to request data from a specified resource.
/// - [POST]: Used to send data to a server to create/update a resource.
/// - [PUT]: Used to update a current resource with new data.
/// - [DELETE]: Used to delete a specified resource.
/// - [PATCH]: Used to apply partial modifications to a resource.
/// - [HEAD]: Used to request the headers of a resource.
/// - [OPTIONS]: Used to describe the communication options for the target resource.
enum BeaconHttpMethod { GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS }

extension BeaconMethodParser on BeaconHttpMethod {
  static BeaconHttpMethod fromString(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return BeaconHttpMethod.GET;
      case 'POST':
        return BeaconHttpMethod.POST;
      case 'PUT':
        return BeaconHttpMethod.PUT;
      case 'DELETE':
        return BeaconHttpMethod.DELETE;
      case 'PATCH':
        return BeaconHttpMethod.PATCH;
      case 'HEAD':
        return BeaconHttpMethod.HEAD;
      case 'OPTIONS':
        return BeaconHttpMethod.OPTIONS;
      default:
        throw ArgumentError('Unsupported HTTP method: $method');
    }
  }

  Color get color {
    switch (this) {
      case BeaconHttpMethod.GET:
        return const Color(0xFF4CAF50);
      case BeaconHttpMethod.POST:
        return const Color(0xFF2196F3);
      case BeaconHttpMethod.PUT:
        return const Color(0xFFFF9800);
      case BeaconHttpMethod.DELETE:
        return const Color(0xFFF44336);
      case BeaconHttpMethod.PATCH:
        return const Color(0xFF9C27B0);
      case BeaconHttpMethod.HEAD:
        return const Color(0xFF673AB7);
      case BeaconHttpMethod.OPTIONS:
        return const Color(0xFF795548);
    }
  }

  AnsiPen get pen {
    switch (this) {
      case BeaconHttpMethod.GET:
        return AnsiPen()..green();
      case BeaconHttpMethod.POST:
        return AnsiPen()..blue();
      case BeaconHttpMethod.PUT:
        return AnsiPen()..yellow();
      case BeaconHttpMethod.DELETE:
        return AnsiPen()..red();
      case BeaconHttpMethod.PATCH:
        return AnsiPen()
          ..rgb(
            r: 156,
            g: 39,
            b: 176,
          );
      case BeaconHttpMethod.HEAD:
        return AnsiPen()..magenta();
      case BeaconHttpMethod.OPTIONS:
        return AnsiPen()
          ..rgb(
            r: 121,
            g: 85,
            b: 72,
          );
    }
  }
}

extension StatusColor on int {
  Color get color {
    if (this >= 200 && this < 300) {
      return const Color(0xFF4CAF50);
    } else if (this >= 300 && this < 400) {
      return const Color(0xFF2196F3);
    } else if (this >= 400 && this < 500) {
      return const Color(0xFFFF9800);
    } else {
      return const Color(0xFFF44336);
    }
  }

  AnsiPen get pen {
    if (this >= 200 && this < 300) {
      return AnsiPen()..green();
    } else if (this >= 300 && this < 400) {
      return AnsiPen()..blue();
    } else if (this >= 400 && this < 500) {
      return AnsiPen()..yellow();
    } else {
      return AnsiPen()..red();
    }
  }
}

/// An abstract class representing an HTTP message in the Beacon library.
/// This class serves as a base for creating HTTP request and response models.
abstract class BeaconHttpMessage {
  /// Constructs a [BeaconHttpMessage] instance.
  ///
  /// This constructor initializes a new instance of the [BeaconHttpMessage] class.
  const BeaconHttpMessage({
    this.xRequestId,
  });

  /// The unique identifier for the message.
  /// This identifier is used to correlate requests and responses.
  /// It is generated by the client and included in the `X-Request-ID` header.
  /// see more at https://http.dev/x-request-id
  final String? xRequestId;
}
