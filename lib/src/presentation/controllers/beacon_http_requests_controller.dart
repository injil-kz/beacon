import 'dart:async';

import 'package:beacon/src/domain/models/http_request.dart';
import 'package:beacon/src/domain/repository/beacon_repository.dart';

class BeaconHttpRequestsController {
  const BeaconHttpRequestsController({
    required StreamController<List<HttpRequest>> controller,
    required BeaconRepository beaconRepository,
  })  : _controller = controller,
        _beaconRepository = beaconRepository;

  final StreamController<List<HttpRequest>> _controller;
  final BeaconRepository _beaconRepository;

  Stream<List<HttpRequest>> get stream => _controller.stream;

  void loadData() {
    _beaconRepository.listenHttpRequests().listen((event) {
      _controller.add(event);
    });
  }

  void dispose() {
    _controller.close();
  }
}
