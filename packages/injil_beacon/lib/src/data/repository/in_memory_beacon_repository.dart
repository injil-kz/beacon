import 'dart:async';

import 'package:injil_beacon/src/domain/models/http_call.dart';
import 'package:injil_beacon/src/domain/models/impl/http_error.dart';
import 'package:injil_beacon/src/domain/models/impl/http_request.dart';
import 'package:injil_beacon/src/domain/models/impl/http_response.dart';
import 'package:injil_beacon/src/domain/repository/beacon_repository.dart';

/// An in-memory implementation of the `BeaconRepository` interface.
class InMemoryBeaconRepository implements BeaconRepository {
  InMemoryBeaconRepository() : _streamController = StreamController<List<BeaconHttpCall>>.broadcast();
  final List<BeaconHttpCall> _calls = [];
  final StreamController<List<BeaconHttpCall>> _streamController;

  @override
  Stream<List<BeaconHttpCall>> get httpCalls => _streamController.stream;

  @override
  Future<List<BeaconHttpCall>> getHttpCalls() => Future.value(_calls);

  @override
  Future<void> close() async {
    await _streamController.close();
  }

  @override
  Future<void> saveError(BeaconHttpError error) async {
    final xRequestCallId = error.xRequestId;
    if (xRequestCallId == null) {
      throw ArgumentError('Error must have a x-request-id header');
    }

    final index = _calls.indexWhere(
      (element) => element.xRequestId == xRequestCallId,
    );
    if (index != -1) {
      _calls[index] = _calls[index].copyWith(newError: error);
      _syncStream();
    } else {
      throw ArgumentError('No request found with x-request-id: $xRequestCallId');
    }
  }

  @override
  Future<void> saveRequest(BeaconHttpRequest request) async {
    final xRequestCallId = request.xRequestId;
    if (xRequestCallId == null) {
      throw ArgumentError('Request must have a x-request-id header');
    }

    final index = _calls.indexWhere(
      (element) => element.xRequestId == xRequestCallId,
    );
    if (index != -1) {
      throw ArgumentError('Request with x-request-id: $xRequestCallId already exists');
    } else {
      _calls.add(BeaconHttpCall(xRequestId: xRequestCallId, request: request));
      _syncStream();
    }
  }

  @override
  Future<void> saveResponse(BeaconHttpResponse response) async {
    final xRequestCallId = response.xRequestId;
    if (xRequestCallId == null) {
      throw ArgumentError('Response must have a x-request-id header');
    }

    final index = _calls.indexWhere(
      (element) => element.xRequestId == xRequestCallId,
    );
    if (index != -1) {
      final call = _calls[index];
      _calls[index] = call.copyWith(
        newResponse: response.copyWith(
          responseTimeInMilliseconds: response.timestampInMilliseconds - call.request.timestampInMilliseconds,
        ),
      );
      _syncStream();
    } else {
      throw ArgumentError('No request found with x-request-id: $xRequestCallId');
    }
  }

  void _syncStream() {
    if (_calls.length > 20) {
      _calls.removeRange(0, _calls.length - 20);
    }

    _streamController.sink.add(List<BeaconHttpCall>.unmodifiable(_calls));
  }
}
