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
      _database = await this.initDatabase();
    }
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, tableName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName($colId INTEGER PRIMARY KEY,$colTitle TEXT,$colDescription TEXT, $colDate TEXT, $colPriority INTEGER)');
  }
  // database and table is created

  // now performing the CRUD operation

  // fetching or read the values from the database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.query(tableName, orderBy: '$colPriority ASC');
    // returning a list of map object List<Map<String,dynamic>> in this format, later we convert it to List of Note List<Note> object to display on the screen
    return result;
  }

  // insert a note to the database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(tableName,
        note.toMap()); // if this line execute successfully then returns 1 if failed then returned 0. thats why return type is Future<int>
    // sqflite plugins deals with map object, so convert it to a map before inserting
    return result;
  }

  // update a note
  Future<int> updateNote(Note note) async {
    Database db = await this.database;
    var result = await db.update(tableName, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int deleteId) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $tableName WHERE $colId = $deleteId');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    int count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Test'));
    assert(count == 2);
  }
}
