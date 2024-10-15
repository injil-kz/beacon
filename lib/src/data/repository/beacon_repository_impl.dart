import 'dart:async';

import 'package:beacon/src/domain/models/http_request.dart';
import 'package:beacon/src/domain/repository/beacon_repository.dart';

class BeaconRepositoryImpl implements BeaconRepository {
  BeaconRepositoryImpl._();

  static final BeaconRepositoryImpl instance = BeaconRepositoryImpl._();

  final StreamController<List<HttpRequest>> _controller = StreamController();

  @override
  Stream<List<HttpRequest>> listenHttpRequests() {
    return _controller.stream;
  }

  @override
  Future<void> addHttpRequestEvent(HttpRequest request) async {
    try {
      /// If [_controller] has previous events
      final previous = await _controller.stream.last;
      _controller.add(previous..add(request));
    } on Exception catch (_) {
      ///If [_controller] don't have previous events, push a first event
      _controller.add([request]);
    }
  }
}
