import 'package:beacon/src/domain/models/http_call.dart';
import 'package:beacon/src/domain/models/impl/http_error.dart';
import 'package:beacon/src/domain/models/impl/http_request.dart';
import 'package:beacon/src/domain/models/impl/http_response.dart';
import 'package:beacon/src/domain/repository/beacon_repository.dart';

/// An in-memory implementation of the `BeaconRepository` interface.
class InMemoryBeaconRepository implements BeaconRepository {
  final List<BeaconHttpCall> _calls = [];

  @override
  Future<List<BeaconHttpCall>> getHttpCalls() => Future.value(_calls);

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
    }
  }

  @override
  Future<void> saveResponse(BeaconHttpResponse request) async {
    final xRequestCallId = request.xRequestId;
    if (xRequestCallId == null) {
      throw ArgumentError('Response must have a x-request-id header');
    }

    final index = _calls.indexWhere(
      (element) => element.xRequestId == xRequestCallId,
    );
    if (index != -1) {
      _calls[index] = _calls[index].copyWith(newResponse: request);
    } else {
      throw ArgumentError('No request found with x-request-id: $xRequestCallId');
    }
  }
}
