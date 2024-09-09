// import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "dev_database.db";
  static final _databaseVersion = 3;

  static final table = 'api_data';
  static final columnId = '_id';
  static final columnData = 'data';
  static final columnUniqueKey = 'unique_key'; // New column for unique key

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUniqueKey TEXT UNIQUE NOT NULL,
        $columnData TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> update(String uniqueKey, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(
      table,
      row,
      where: '$columnUniqueKey = ?',  // Use unique key to identify the record
      whereArgs: [uniqueKey],
    );
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<Map<String, dynamic>?> getDataByUniqueKey(String uniqueKey) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> results = await db.query(
      table,
      where: '$columnUniqueKey = ?',
      whereArgs: [uniqueKey],
    );

    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }
}
