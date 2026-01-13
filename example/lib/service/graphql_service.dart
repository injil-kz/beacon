import 'package:beacon_graphql_adapter/beacon_graphql_adapter.dart';
import 'package:graphql/client.dart';
import 'package:injil_beacon/injil_beacon.dart';

class GraphqlService {
  GraphQLClient? _client;

  Future<void> simulateGraphqlCalls() async {
    final httpLink = HttpLink(
      'https://countries.trevorblades.com/',
    );

    // Create the beacon link
    final beaconLink = BeaconGraphqlLink(
      beaconConfiguration: DefaultBeaconConfiguration(),
      uri: 'https://countries.trevorblades.com/',
    );

    // Chain them: BeaconLink -> HttpLink
    final Link link = beaconLink.concat(httpLink);

    _client = GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which DOES NOT persist to disk
      cache: GraphQLCache(),
    );

    print('Starting GraphQL simulation...');

    // 1. Successful Query
    try {
      final QueryOptions options = QueryOptions(
        document: gql(
          r'''
          query GetCountries {
            countries(filter: {code: {eq: "KZ"}}) {
              code
              name
              emoji
            }
          }
          ''',
        ),
      );
      final QueryResult result = await _client!.query(options);

      if (result.hasException) {
        print('Query exception: ${result.exception.toString()}');
      } else {
        print('Query successful: ${result.data}');
      }
    } catch (e) {
      print('Caught unexpected error: $e');
    }

    await Future.delayed(Duration(seconds: 2));

    // 2. Error Query (Field that doesn't exist to provoke validation error from server)
    try {
      final QueryOptions options = QueryOptions(
        document: gql(
          r'''
          query ErrorQuery {
            countries {
              invalidField
            }
          }
          ''',
        ),
      );
      final QueryResult result = await _client!.query(options);

      if (result.hasException) {
        print('Expected Query exception: ${result.exception.toString()}');
      }
    } catch (e) {
      print('Caught unexpected error: $e');
    }
  }
}
