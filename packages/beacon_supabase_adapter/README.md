# Beacon Supabase Adapter

Supabase adapter for [Beacon network requests.](https://pub.dev/packages/injil_beacon)

## Usage

```dart
import 'package:beacon_supabase_adapter/beacon_supabase_adapter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injil_beacon/injil_beacon.dart';

void main() async {
  // Initialize Beacon
  // final beaconConfig = ...
  
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
    httpClient: BeaconSupabaseClient(
        beaconConfiguration: beaconConfig,
    ),
  );
}
```
