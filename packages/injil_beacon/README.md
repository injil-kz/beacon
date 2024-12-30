# Beacon Package

The Beacon package is a Flutter plugin that provides functionalities for loggin HTTP Calls


## Features

- Loggin Request/Response/Error
- Good UI for Test
- Zero dependecies
- Adapters for different HTTP Clients
- Inspectors for mobile/desktop/web platforms

| HTTP Calls | Request | Response |
|------------|---------|----------|
| ![HTTP Calls](https://github.com/injil-kz/beacon/blob/main/images/http_calls.png?raw=true) | ![Request](https://github.com/injil-kz/beacon/blob/main/images/request.png?raw=true) | ![Response](https://github.com/injil-kz/beacon/blob/main/images/response.png?raw=true)
-------

| Shake to Open |
|------------|
| ![ShakeToOpen](https://github.com/injil-kz/beacon/blob/main/images/shake.gif?raw=true) |


| Easy copy cURL | Easy copy Body/Headers/QueryParams |
|---------|---------|
| ![Easy copy cURL](https://github.com/injil-kz/beacon/blob/main/images/cURL.gif?raw=true) | ![Easy copy cURL](https://github.com/injil-kz/beacon/blob/main/images/json.gif?raw=true) |

## Getting Started

To use this package, add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  injil_beacon: latest
  beacon_dio_adapter: latest
  beacon_mobile_inspector: latest
```

## Usage

### Beacon

Import the beacon package and use it to detect and interact with beacons:

```dart
import 'package:injil_beacon/injil_beacon.dart';

void main() {
  final configuration = DefaultBeaconConfiguration();
  // get Router of your application
  final router = AppRouter();

  final beaconInspector = BeaconMobileInspector(
    // Provide BeaconConfiguration for Inspector
    configuration: configuration,
    // Provide navigatorKey for Inspector
    navigatorKey: router.navigatorKey,
    // shake smartphone to open Inspector
    shakeToOpen: true,
  );
  // Initialize BeaconInspector
  beaconInspector.init();

  runApp(
    MyApp(
      configuration: configuration,
      router: router,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.configuration,
    required this.router,
  });

  final BeaconConfiguration configuration;
  final AppRouter router;
  @override
  Widget build(BuildContext context) {
    return BeaconConfigurationProvider(
      configuration: configuration,
      child: MaterialApp.router(
        routerConfig: router.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
```

### Beacon Dio Adapter

Import the beacon Dio adapter package and use it for network requests:

```dart
import 'package:injil_beacon/injil_beacon.dart';
import 'package:beacon_dio_adapter/beacon_dio_adapter.dart';

final configuration = DefaultBeaconConfiguration();
 
_dio?.interceptors.add(
  BeaconDioAdapter(beaconConfiguration: configuration),
);
```

## Example

Check out the [example](example) directory for a complete example of how to use this package.

## Contributing

Contributions are welcome! Please see the [contributing guidelines](CONTRIBUTING.md) for more information.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.