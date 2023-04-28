import 'dart:io';

import 'package:fimber/fimber.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static const _databaseName = "cache_manager.db";
  static const _databaseVersion = 2;

  static const responseTable = 'response';
  static const requestTable = 'request';

  static const id = '_id';
  static const body = 'request_body';
  static const url = 'request_url';
  static const header = 'request_header';
  static const type = 'request_type';

  static const requestId = 'request_id';
  static const response = 'response_body';
  static const responseHeader = 'response_header';

  DBHelper._privateConstructor();

  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Map<int, String> migrationScripts = {
    1: '''SELECT * FROM $responseTable''',
    2: '''ALTER TABLE $responseTable ADD COLUMN $responseHeader TEXT''',
  };

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          try {
            await db.execute(migrationScripts[i]!);
          } catch (e) {
            Fimber.d("error $e");
          }
        }
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    var tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name");
    List tableList = tables.map((e) => e["name"]).toList();
    if (tableList.contains(requestTable) == false) {
      await db.execute('''
          CREATE TABLE $requestTable (
            $id INTEGER PRIMARY KEY,
            $body TEXT NOT NULL, 
            $url TEXT NOT NULL,
            $header TEXT NOT NULL,
            $type TEXT NOT NULL
          )
          ''');
    }

    if (tableList.contains(responseTable) == false) {
      await db.execute('''
          CREATE TABLE $responseTable (
            $id INTEGER PRIMARY KEY,
            $requestId TEXT NOT NULL,
            $url TEXT NOT NULL,
            $type TEXT NOT NULL,
            $response TEXT NOT NULL,
            FOREIGN KEY($requestId) REFERENCES $requestTable($id)
          )
          ''');
    }
  }

  Future<int> insertRequest(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(requestTable, row);
  }

  Future<int> insertResponse(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(responseTable, row);
  }

  Future<int> updateRequest(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int columnId = row[id];
    return await db
        .update(requestTable, row, where: '$id = ?', whereArgs: [columnId]);
  }

  Future<int> deleteRequest(int columnId) async {
    Database db = await instance.database;
    return await db
        .delete(requestTable, where: '$id = ?', whereArgs: [columnId]);
  }

  Future<int> deleteAllRequest() async {
    Database db = await instance.database;
    return await db.delete(requestTable);
  }

  Future<int> updateResponse(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int columnId = row[id];
    return await db
        .update(responseTable, row, where: '$id = ?', whereArgs: [columnId]);
  }

  Future<int> deleteResponse(int columnId) async {
    Database db = await instance.database;
    return await db
        .delete(responseTable, where: '$id = ?', whereArgs: [columnId]);
  }

  Future<int> deleteAllResponse() async {
    Database db = await instance.database;
    return await db.delete(responseTable);
  }

  Future<List<Map<String, dynamic>>> querySingleResponse(
      {var column, where, whereArgs}) async {
    Database db = await instance.database;
    return await db.query(responseTable,
        columns: column, where: where, whereArgs: whereArgs);
  }
}
