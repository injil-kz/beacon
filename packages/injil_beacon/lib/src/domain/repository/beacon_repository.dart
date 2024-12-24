import 'dart:async';

import 'package:injil_beacon/src/domain/models/http_call.dart';
import 'package:injil_beacon/src/domain/models/impl/http_error.dart';
import 'package:injil_beacon/src/domain/models/impl/http_request.dart';
import 'package:injil_beacon/src/domain/models/impl/http_response.dart';

/// An interface for interacting with the Beacon repository.
abstract class BeaconRepository {
  /// Saves a BeaconHttpRequest to the repository.
  ///
  /// This method takes a [BeaconHttpRequest] object and saves it to the repository.
  ///
  /// [request] - The HTTP request to be saved.
  Future<void> saveRequest(BeaconHttpRequest request);

  /// Saves a BeaconHttpResponse to the repository.
  ///
  /// This method takes a [BeaconHttpResponse] object and saves it to the repository.
  ///
  /// [request] - The HTTP response to be saved.
  Future<void> saveResponse(BeaconHttpResponse request);

  /// Saves a BeaconHttpError to the repository.
  ///
  /// This method takes a [BeaconHttpError] object and saves it to the repository.
  ///
  /// [request] - The HTTP error to be saved.
  Future<void> saveError(BeaconHttpError request);

  /// Retrieves all BeaconHttpCalls from the repository.
  ///
  /// This method returns a list of all [BeaconHttpCall] objects stored in the repository.
  ///
  /// Returns a [Future] that completes with a list of [BeaconHttpCall] objects.
  Future<List<BeaconHttpCall>> getHttpCalls();

  Stream<List<BeaconHttpCall>> get httpCalls;

  Future<void> close();
}
