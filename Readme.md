# Beacon Package

The Beacon package is a Flutter plugin that provides functionalities for beacon detection and interaction. This package includes a core beacon package and a Dio adapter for network requests.

## Features

- Beacon detection and interaction
- Network requests using Dio adapter

## Getting Started

To use this package, add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  beacon: ^1.0.0
  beacon_dio_adapter: ^1.0.0
```

## Usage

### Beacon

Import the beacon package and use it to detect and interact with beacons:

```dart
import 'package:injil_beacon/beacon.dart';

void main() {
  // Initialize the beacon manager
  BeaconManager beaconManager = BeaconManager();

  // Start scanning for beacons
  beaconManager.startScanning();
}
```

### Beacon Dio Adapter

Import the beacon Dio adapter package and use it for network requests:

```dart
import 'package:injil_beacon_dio_adapter/beacon_dio_adapter.dart';
import 'package:dio/dio.dart';

void main() {
  // Initialize Dio
  Dio dio = Dio();

  // Add the beacon Dio adapter
  dio.interceptors.add(BeaconDioAdapter());

  // Make a network request
  dio.get('https://example.com');
}
```

## Example

Check out the [example](example) directory for a complete example of how to use this package.

## Contributing

Contributions are welcome! Please see the [contributing guidelines](CONTRIBUTING.md) for more information.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.