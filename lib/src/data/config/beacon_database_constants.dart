class BeaconDatabaseConstants{
  const BeaconDatabaseConstants._();
  static const tableName = 'HttpRequest';
  static const allTableColumns = '(id,path,response,body,query,headers,connectionTimeout,receiveTimeout,method)';
}