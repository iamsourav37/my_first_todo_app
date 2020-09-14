import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'note.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // singleton DatabaseHelper
  static Database _database; // singleton database
  final int dbVersion = 1;
  String tableName = "todo.db"; // table name with extension
// table column name
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colDate = "date";
  String colPriority = "priority";

  DatabaseHelper._createInstance(); // private constructor
  factory DatabaseHelper() {
    // singleton database helper constructor
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

// getter for getting the database
  Future<Database> get database async {
    if (_database == null) {
      this.initDatabase();
    }
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, tableName);
    return openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    db.execute(
        'CREATE TABLE $tableName($colId INTEGER PRIMARY KEY,$colTitle TEXT,$colDescription TEXT, $colDate TEXT, $colPriority INTEGER)');
  }
}
