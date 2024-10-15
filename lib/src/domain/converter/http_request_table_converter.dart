import 'package:beacon/src/data/config/beacon_database_constants.dart';
import 'package:beacon/src/domain/models/http_request.dart';

class HttpRequestTableConverter {
  String singleInsertQuery(HttpRequest request) {
    return 'INSERT INTO ${BeaconDatabaseConstants.tableName}${insertableColumns(request)} VALUES ${insertableColumns(request)}';
  }

  String insertableValues(HttpRequest request){
    return '''(
    ${request.path}
    
    )''';
  }

  String insertableColumns(HttpRequest request) {
    return '''(path,
    ${appendColumnIfValueExist('response,', request.response)})
    ${appendColumnIfValueExist('body,', request.body)})
    ${appendColumnIfValueExist('query,', request.query)})
    ${appendColumnIfValueExist('headers,', request.headers)})
    ${appendColumnIfValueExist('connectionTimeout,', request.connectionTimeout)})
    ${appendColumnIfValueExist('receiveTimeout,', request.receiveTimeout)})
    ${appendColumnIfValueExist('method,', request.requestInCurl)})
    ''';
  }

  Object? appendValueIfExist(){

  }

  String appendColumnIfValueExist(String name, Object? value) {
    return value == null ? '' : name;
  }
}
