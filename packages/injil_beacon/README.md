# Beacon Package

The Beacon package is a Flutter plugin that provides functionalities for logging HTTP Calls.

## Features

- Log Requests, Responses, and Errors
- Developer and QA friendly UI/UX
- Zero dependencies for the core package
- Adapters for different HTTP Clients (Dio, GraphQL, Supabase)
- Inspectors for mobile platforms (Shake to open)

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
  beacon_mobile_inspector: latest
  
  # Add the adapter for your HTTP client
  beacon_dio_adapter: latest
  beacon_graphql_adapter: latest
  beacon_supabase_adapter: latest
```

## Usage

### 1. Initialize Beacon and Inspector

Import the beacon package and set up the mobile inspector.

```dart
import 'package:injil_beacon/injil_beacon.dart';
import 'package:beacon_mobile_inspector/beacon_mobile_inspector.dart';

void main() async {
  final configuration = DefaultBeaconConfiguration();
  // Get Router or NavigatorKey of your application
  final navigatorKey = GlobalKey<NavigatorState>();

  final beaconInspector = BeaconMobileInspector(
    // Provide BeaconConfiguration for Inspector
    configuration: configuration,
    // Provide navigatorKey for Inspector to show overlay
    navigatorKey: navigatorKey,
    // Shake smartphone to open Inspector
    shakeToOpen: true,
  );
  
  // Initialize BeaconInspector
  await beaconInspector.init();

  runApp(
    MyApp(
      configuration: configuration,
      navigatorKey: navigatorKey,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.configuration,
    required this.navigatorKey,
  });

  final BeaconConfiguration configuration;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return BeaconConfigurationProvider(
      configuration: configuration,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const Scaffold(body: Center(child: Text('Beacon Example'))),
      ),
    );
  }
}
```

### 2. Connect Your HTTP Client

Beacon provides adapters for popular HTTP clients. Use the one that matches your tech stack.

#### Dio Adapter

```dart
import 'package:beacon_dio_adapter/beacon_dio_adapter.dart';
import 'package:dio/dio.dart';

final dio = Dio();

// Add BeaconDioAdapter to interceptors
dio.interceptors.add(
  BeaconDioAdapter(beaconConfiguration: configuration),
);
```

#### GraphQL Adapter

```dart
import 'package:beacon_graphql_adapter/beacon_graphql_adapter.dart';
import 'package:graphql/client.dart';

final httpLink = HttpLink('https://api.github.com/graphql');

// Create BeaconGraphqlLink
final beaconLink = BeaconGraphqlLink(
  beaconConfiguration: configuration,
  uri: 'https://api.github.com/graphql', // Optional: Helps identify requests in Inspector
);

// Chain the links
final link = Link.from([beaconLink, httpLink]);

final client = GraphQLClient(
  cache: GraphQLCache(),
  link: link,
);
```

#### Supabase Adapter

```dart
import 'package:beacon_supabase_adapter/beacon_supabase_adapter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
  httpClient: BeaconSupabaseClient(
    beaconConfiguration: configuration,
  ),
);
```

## Example

Check out the [example](example) directory for a complete example of how to use this package.

## Contributing

Contributions are welcome! Please see the [contributing guidelines](CONTRIBUTING.md) for more information.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
