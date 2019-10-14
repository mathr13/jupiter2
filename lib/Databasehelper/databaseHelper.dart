import 'dart:async';
import 'dart:io' as io;
import 'package:jupiter/Constant/string_constant.dart';
import 'package:jupiter/Services/firebaseFunctions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseHelper {
  static final DatabaseHelper _instance=new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _dbSystem;
  static Database _dbContent;

  Future<Database> get dbSystem async {
    if (_dbSystem != null) {
      return _dbSystem;
    }
      _dbSystem=await initDbSystem();
      return _dbSystem;
    }

  Future<Database> get dbContent async {
    if (_dbContent != null) {
      return _dbContent;
    }
      _dbContent=await initDbContent(contentDb+".db");
      return _dbContent;
  }

  DatabaseHelper.internal();

  initDbSystem() async {
    // io.Directory documentsDirectory=await getApplicationDocumentsDirectory();
    String documentsDirectory=await getDatabasesPath();
    String path=join(documentsDirectory, systemDb);
    print("1------------------------***DATABASE***------------------------");
    print(path);
    var theDbSystem=await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDbSystem;
  }
  initDbContent(String contentDb) async {
    // io.Directory documentsDirectory=await getApplicationDocumentsDirectory();
    String documentsDirectory=await getDatabasesPath();
    String path=join(documentsDirectory, contentDb);
    print("2------------------------***DATABASE***------------------------");
    print(path);
    var theDbContent=await openDatabase(path, version: 1);
    return theDbContent;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE USER(userName TEXT, firstName TEXT, lastName TEXT, userId NUMBER, lang TEXT, PRIMARY KEY(userId))");
    await db.execute("CREATE TABLE NotificationQueue(queueId TEXT ,projectId NUMBER,category TEXT ,message TEXT ,type TEXT ,seqNo NUMBER,groupSeqNo NUMBER, timestamp NUMBER,status TEXT, uri TEXT, params TEXT,PRIMARY KEY(queueId,projectId))");
    await db.execute("CREATE TABLE PROJECT(projectName TEXT, projectId NUMBER, init BOOL, defaultProject BOOL, db TEXT,PRIMARY KEY(projectId))");
    await db.execute("CREATE TABLE MENU(menuIndex NUMBER,projectId NUMBER, menuId TEXT, menuURL TEXT, perm TEXT, menus TEXT,wsId TEXT,PRIMARY KEY(menuId,projectId))");
    await db.execute("CREATE TABLE PERMISSION(permissionId TEXT, projectId NUMBER,PRIMARY KEY(projectId,permissionId))");
    await db.execute("CREATE TABLE GLOBALVARIABLE(projectId NUMBER, key TEXT, value TEXT)");
    await db.execute("CREATE TABLE LABEL(key TEXT, value TEXT, localization TEXT, projectId NUMBER, appType TEXT,PRIMARY KEY(projectId,key,localization))");
    await db.execute("CREATE TABLE system_tables_info(tableId NUMBER, tableName TEXT, status BOOLEAN,PRIMARY KEY(tableId))");
    await db.execute("INSERT INTO system_tables_info(tableId, tableName) VALUES(1,'USER'),(2,'NotificationQueue'),(3,'PROJECT'),(4,'MENU'),(5,'PERMISSION'),(6,'GLOBALVARIABLE'),(7,'LABEL'),(8,'DEFINITION')");
    await db.execute("CREATE TABLE DEFINITION(formId TEXT PRIMARY KEY, projectId Number, name TEXT, template TEXT)");
    await db.execute("CREATE TABLE WORKSPACE(wsId TEXT PRIMARY KEY, wsName Number,defaultTemplateId TEXT)");
    await db.execute("CREATE TABLE NAVIGATION_MAPPING(templateId TEXT,buttonId TEXT,componentType TEXT,  componentSubType TEXT, redirectTemplateId TEXT,label TEXT,operation TEXT,containerId TEXT,wsId TEXT,PRIMARY KEY (templateId,buttonId))");


  }

  Future<void> populateTableWithMapping(String tableName, Map<String, dynamic> value) async {
    var dbClient=await dbSystem;
    await dbClient.insert(tableName, value,conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<void> populateTableWithCustomColumn(String tableName, Map<String, dynamic> value,String columnName,dynamic columnValue) async {
    var dbClient = await dbSystem;
    value.putIfAbsent("$columnName", () => columnValue);
    await dbClient.insert(tableName, value,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map>> checkIfNotificationReceived(String tableName) async {
    var dbClient = await dbSystem;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName");
    return res;
  }

  Future<int> checkForDefaultProject() async {
    var dbClient=await dbSystem;
    List<Map> res=await dbClient.rawQuery("SELECT projectId FROM PROJECT WHERE defaultProject = 1");
    if(res.isEmpty) {res=await dbClient.rawQuery("SELECT projectId FROM PROJECT");}
    return Future.value(res[0]["projectId"]);
  }

  Future<void> updateColumn(String tableName, String columnName, dynamic columnValue) async {
    var dbClient = await dbSystem;
    await dbClient.rawQuery("UPDATE  $tableName SET '$columnName' = '$columnValue'");
  }

  Future<List> fetchMenuData() async {
    var dbClient=await dbSystem;
    var res=await dbClient.rawQuery("SELECT LABEL.value, MENU.wsId FROM LABEL INNER JOIN MENU ON LABEL.key=MENU.menuId");
    return res.toList();
  }

  Future<List> fetchTablesData() async {
    var dbClient = await dbSystem;
    List<Map<String,dynamic>> res = await dbClient.rawQuery("SELECT tableName FROM system_tables_info WHERE tableName IS NOT NULL");
    return res.toList();
  }

  Future<List<dynamic>> sortingNotificationData() async {
    var dbClient=await dbSystem;
    List<dynamic> res = await dbClient.rawQuery('SELECT * FROM NotificationQueue WHERE type = "BO" AND category = "INIT" AND status = "ACTIVE" AND projectId = -1 ORDER BY groupSeqNo, seqNo ASC');
    return res;
  }

  Future<List<dynamic>> getProjectIdFromNotificationData() async {
    var dbClient=await dbSystem;
    List<dynamic> res = await dbClient.rawQuery('SELECT * FROM NotificationQueue WHERE projectId = -1');
    var rese = await dbClient.rawQuery('SELECT * FROM NotificationQueue');
    // print(rese.length);
    // for(int q=0;q<rese.length;q++) {
    //   print(rese[q]);
    //   print("---------------------------------------------------------------");
    // }
    return res;
  }

  Future<List<dynamic>> fetchInitNotificationRecords() async {
    var dbClient=await dbSystem;
    List<dynamic> res = await dbClient.rawQuery('SELECT * from NotificationQueue WHERE projectId in (SELECT projectId FROM PROJECT WHERE init = 1) AND type = "BO" AND category = "INIT" AND status = "ACTIVE" ORDER BY groupSeqNo, seqNo ASC');
    return res.toList();
  }

  Future<List<dynamic>> fetchInitNotificationRecordsForDefaultProject() async {
    var dbClient=await dbSystem;
    List<dynamic> res = await dbClient.rawQuery('SELECT * from NotificationQueue WHERE projectId in (SELECT projectId FROM PROJECT WHERE defaultProject = 1) AND type = "BO" AND category = "INIT" AND status = "ACTIVE" ORDER BY groupSeqNo, seqNo ASC');
    return res.toList();
  }

  Future<List<dynamic>> fetchFirstProject() async {
    var dbClient=await dbSystem;
    List<dynamic> res = await dbClient.rawQuery('SELECT * FROM PROJECT LIMIT 1');
    return res.toList();
  }

  Future<int> checkDefinitionData() async {
    var dbClient = await dbSystem;
    var res = await dbClient.rawQuery("SELECT * FROM DEFINITION");
    return res.length;
  }

  Future<List> fetchData(String table) async {
    var dbClient = await dbSystem;
    var data = await dbClient.rawQuery("SELECT * FROM '$table' ");
    return data.toList();
  }
  Future<List> count(String table) async {
    var dbClient = await dbSystem;
    var value = await dbClient.rawQuery("SELECT COUNT(1) FROM '$table' ");
    return value;
  }
  Future<void> insertWsIdInMenus() async{
    var dbClient = await dbSystem;
     await dbClient.rawQuery("UPDATE MENU SET wsId='15356537dedfer' WHERE menuIndex = 9 ");
  }
  Future<List> fetchTemplateID(String id) async {
    var dbClient = await dbSystem;
    String query = "SELECT * FROM DEFINITION WHERE template LIKE '%$id%' ";
//    print(query);
    var res = await dbClient.rawQuery(query);
    return  res;
  }

  Future<List> fetchWorkSpaceData(String id) async {
    var dbClient = await dbSystem;
    String query = "SELECT * FROM WORKSPACE WHERE wsId = '$id' ";
//    print(query);
    var res = await dbClient.rawQuery(query);
    return  res;
  }
  Future<void> createTable(String tableName, String columnName, String columnDataType) async {
		var dbClient = await dbContent;
  await dbClient.execute('CREATE TABLE IF NOT EXISTS $tableName($columnName $columnDataType)');
	}
  Future<void> addColumnToTable(String tableName, String columnName, String columnDataType) async {
		var dbClient = await dbContent;
		await dbClient.execute('ALTER TABLE $tableName ADD $columnName $columnDataType;');
	}
  Future<dynamic> checkIfTableExist(String tableName) async {
		var dbClient = await dbSystem;
		var res = await dbClient.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return res.length;
	}
}