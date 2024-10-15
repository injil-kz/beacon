import 'package:sqflite/sqflite.dart';

class BeaconSqfliteDatabase {
  BeaconSqfliteDatabase._();

  static Database? _database;

  static final BeaconSqfliteDatabase _instance = BeaconSqfliteDatabase._();

  BeaconSqfliteDatabase get instance => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase('http_requests_database.db', version: 1, onCreate: (db, version) {
      db.execute('''CREATE TABLE HttpRequest(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        path TEXT  NOT NULL,
        response TEXT,
        body TEXT,
        query TEXT,
        headers TEXT,
        timestamp num, 
        connectionTimeout num,
        receiveTimeout num,
        method TEXT,
    )''');
    });
  }
}
