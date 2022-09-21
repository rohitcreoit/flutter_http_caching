import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class RequestDBHelper {
  static const _databaseName = "Request.db";
  static const _databaseVersion = 1;

  static const table = 'requests';

  static const id = '_id';
  static const body = 'request_body';
  static const url = 'request_url';
  static const header = 'request_header';
  static const type = 'request_type';

  RequestDBHelper._privateConstructor();

  static final RequestDBHelper instance = RequestDBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $id INTEGER PRIMARY KEY,
            $body TEXT NOT NULL, 
            $url TEXT NOT NULL,
            $header TEXT NOT NULL,
            $type TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int columnId = row[id];
    return await db.update(table, row, where: '$id = ?', whereArgs: [columnId]);
  }

  Future<int> delete(int columnId) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$id = ?', whereArgs: [columnId]);
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.delete(table);
  }
}
