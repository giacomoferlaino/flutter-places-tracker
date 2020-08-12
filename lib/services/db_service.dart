import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../providers/places.dart';

class DBService {
  String _dbPath;
  Database db;

  Future<void> _onCreate(Database db, int version) {
    return db.execute(
        'CREATE TABLE ${Places.tableName} (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
  }

  Future<void> init(String dbName) async {
    _dbPath = await getDatabasesPath();
    db = await openDatabase(
      join(_dbPath, dbName),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    return db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    return db.query(table);
  }
}
