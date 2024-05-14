import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String _dbName = 'cronometros.db';
  static const int _dbVersion = 1;

  DatabaseProvider._();
  static final DatabaseProvider instance = DatabaseProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      '$path/$_dbName',
      version: _dbVersion,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cronometros(
        id INTEGER PRIMARY KEY,
        start_time TEXT,
        elapsed_time INTEGER
      )
    ''');
  }
}
