import 'dart:async';

import 'package:beacon/src/domain/repository/beacon_repository.dart';
import 'package:beacon/src/presentation/controllers/beacon_http_requests_state.dart';

class BeaconHttpRequestsController {
  const BeaconHttpRequestsController({
    required BeaconHttpRequestsState state,
    required StreamController<BeaconHttpRequestsState> controller,
    required BeaconRepository beaconRepository,
  })  : _controller = controller,
        _state = state,
        _beaconRepository = beaconRepository;

  final BeaconHttpRequestsState _state;
  final StreamController<BeaconHttpRequestsState> _controller;
  final BeaconRepository _beaconRepository;


  void addState(BeaconHttpRequestsState state) {
    if (_controller.isClosed) {
      return;
    }

    _controller.add(state);
  }

  void dispose() {
    _controller.close();
  }
}
