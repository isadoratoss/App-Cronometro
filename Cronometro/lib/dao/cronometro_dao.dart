import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/cronometro.dart';

class CronometroDAO {
  static const _dbName = 'cronometros.db';
  static const _dbVersion = 1;
  static const _tableName = 'cronometros';

  CronometroDAO._privateConstructor();
  static final CronometroDAO instance = CronometroDAO._privateConstructor();

  late Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _dbName);
    return await openDatabase(
      databasePath,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        counter INTEGER,
        is_running INTEGER,
        is_finished INTEGER,
        is_paused INTEGER
      )
    ''');
  }

  Future<void> insertCronometro(Cronometro cronometro) async {
    final db = await database;
    await db.insert(
      _tableName,
      cronometro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Cronometro>> getFinishedCronometros() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'is_finished = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return Cronometro(
        id: maps[i]['id'],
        counter: maps[i]['counter'],
        isRunning: maps[i]['is_running'] == 1,
        isFinished: maps[i]['is_finished'] == 1,
        isPaused: maps[i]['is_paused'] == 1,
      );
    });
  }
}
