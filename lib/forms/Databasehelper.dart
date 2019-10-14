import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "data.db");
    print(path);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE LOV (lovId TEXT PRIMARY KEY ,displayName TEXT,displayValue TEXT,type TEXT,value BOOLEAN)");
    await db.execute(
        "CREATE TABLE Navigate (id TEXT PRIMARY KEY ,navigationCtrlId TEXT,redirectFormId TEXT,actionType TEXT,templateId TEXT,title TEXT)");
  }

  Future insert(String tableName,Map<String, dynamic> map) async {
    var dbClient = await db;
    dbClient.insert(tableName, map,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List> fetchTablesData(String type) async {
    var dbClient = await db;
//    String query = "SELECT * FROM LOV WHERE type LIKE '$type' ";
//    print(query);
    var res = await dbClient.rawQuery("SELECT * FROM LOV WHERE type LIKE '$type' ");
    return  res.toList();

  }

//  Future<List> fetchTemplateID(String columnName,String id) async {
//    var dbClient = await db;
//    String query = "SELECT templateId ,title FROM Navigate WHERE navigationCtrlId LIKE '$id' ";
//    print(query);
//    var res = await dbClient.rawQuery(query);
//    print(res);
//    return  res;
//
//  }


}