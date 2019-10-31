import 'dart:async';
import 'package:jupiter/Constant/stringConstant.dart';
import 'package:jupiter/Services/firebaseFunctions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:core';



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
    await db.execute("CREATE TABLE NOTIFICATION_QUEUE(queueId TEXT ,projectId NUMBER,category TEXT ,message TEXT ,type TEXT ,seqNo NUMBER,groupSeqNo NUMBER, timestamp NUMBER,status TEXT, uri TEXT, params TEXT,PRIMARY KEY(queueId,projectId))");
    await db.execute("CREATE TABLE PROJECT(projectName TEXT, projectId NUMBER, init BOOL, defaultProject BOOL, db TEXT,PRIMARY KEY(projectId))");
    await db.execute("CREATE TABLE MENU(menuIndex NUMBER,projectId NUMBER, menuId TEXT, menuURL TEXT, iconUrl TEXT, perm TEXT, menus TEXT,wsId TEXT,PRIMARY KEY(menuId,projectId))");
    await db.execute("CREATE TABLE PERMISSION(permissionId TEXT, projectId NUMBER,PRIMARY KEY(projectId,permissionId))");
    await db.execute("CREATE TABLE GLOBALVARIABLE(projectId NUMBER, key TEXT, value TEXT)");
    await db.execute("CREATE TABLE LABEL(key TEXT, value TEXT, localization TEXT, projectId NUMBER, appType TEXT,PRIMARY KEY(projectId,key,localization))");
    await db.execute("CREATE TABLE system_tables_info(tableId NUMBER, tableName TEXT, status BOOLEAN,PRIMARY KEY(tableId))");
    await db.execute("INSERT INTO system_tables_info(tableId, tableName) VALUES(1,'USER'),(2,'NOTIFICATION_QUEUE'),(3,'PROJECT'),(4,'MENU'),(5,'PERMISSION'),(6,'GLOBALVARIABLE'),(7,'LABEL'),(8,'DEFINITION')");
    await db.execute("CREATE TABLE DEFINITION(formId TEXT PRIMARY KEY, projectId Number, name TEXT, template TEXT)");
    await db.execute("CREATE TABLE WORKSPACE(wsId TEXT PRIMARY KEY, wsName Number,defaultTemplateId TEXT)");
    await db.execute("CREATE TABLE NAVIGATION_MAPPING(templateId TEXT,buttonId TEXT,componentType TEXT,  componentSubType TEXT, redirectTemplateId TEXT,label TEXT,operation TEXT,containerId TEXT,wsId TEXT,PRIMARY KEY (templateId,buttonId))");
    await db.execute("CREATE TABLE TRANS_QUEUE(transQueueId TEXT, requestId TEXT, requestData TEXT, lookUpData TEXT, projectId NUMBER, userId NUMBER, status TEXT, syncStatus TEXT, conflicts TEXT, responseData TEXT, wsId NUMBER, createdData TEXT, updateData TEXT)");
    // await db.execute("CREATE TABLE TRANS_DOC_QUEUE(transDocId TEXT, requestId TEXT, transDocMetaData TEXT, status TEXT, syncStatus TEXT, noOfAttempts NUMBER, docLocalPath TEXT, docName TEXT, createdDate TEXT, updatedDat TEXT)");
  }

  Future<void> populateTableWithMapping(String tableName, Map<String, dynamic> value, bool isSystemDatabase) async {
    var dbClient;
    if(isSystemDatabase==true) {dbClient=await dbSystem;}else {dbClient=await dbContent;}
    await dbClient.insert(tableName, value,conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<void> populateTableWithCustomColumn(String tableName, Map<String, dynamic> value,String columnName,dynamic columnValue, bool isSystemDatabase) async {
    var dbClient;
    if(isSystemDatabase==true) {
      dbClient = await dbSystem;
    }else {
      dbClient = await dbContent;
    }
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

  Future<List> fetchTablesData(bool isSystemtable) async {
    var dbClient;
    if(isSystemtable == true) {
      dbClient = await dbSystem;
    }else {dbClient = await dbContent;}
    List<Map> res = await dbClient.rawQuery('SELECT name FROM sqlite_master WHERE type = "table" AND name != "system_tables_info"');
    return res.toList();
  }

  Future<List<dynamic>> sortingNotificationData() async {
    var dbClient=await dbSystem;
    List<dynamic> res = await dbClient.rawQuery('SELECT * FROM NOTIFICATION_QUEUE WHERE type = "BO" AND category = "INIT" AND status = "ACTIVE" AND projectId = -1 ORDER BY groupSeqNo, seqNo ASC');
    return res;
  }

  Future<List<dynamic>> getProjectIdFromNotificationData() async {
    var dbClient=await dbSystem;
    List<dynamic> res = await dbClient.rawQuery('SELECT * FROM NOTIFICATION_QUEUE WHERE projectId = -1');
    return res;
  }

  Future<List<dynamic>> fetchInitNotificationRecords() async {
    var dbClient=await dbSystem;
    List<dynamic> res = await dbClient.rawQuery('SELECT * from NOTIFICATION_QUEUE WHERE projectId in (SELECT projectId FROM PROJECT WHERE init = 1) AND type = "BO" AND category = "INIT" AND status = "ACTIVE" ORDER BY groupSeqNo, seqNo ASC');
    return res.toList();
  }

  Future<List<dynamic>> fetchInitNotificationRecordsForDefaultProject() async {
    var dbClient=await dbSystem;
    List<dynamic> res = await dbClient.rawQuery('SELECT * from NOTIFICATION_QUEUE WHERE projectId in (SELECT projectId FROM PROJECT WHERE defaultProject = 1) AND type = "BO" AND category = "INIT" AND status = "ACTIVE" ORDER BY groupSeqNo, seqNo ASC');
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

  Future<List> fetchData(String table,bool isSystemDatabase) async {
    var dbClient;
    if(isSystemDatabase==true) {
      dbClient = await dbSystem;
    }else {dbClient = await dbContent;}
    var data = await dbClient.rawQuery("SELECT * FROM '$table' ");
    return data.toList();
  }
  Future<List> count(String table,bool isSystemDatabase) async {
    var dbClient;
    if(isSystemDatabase==true) {
      dbClient = await dbSystem;
    }else {dbClient = await dbContent;}
    var value = await dbClient.rawQuery("SELECT COUNT(1) FROM '$table' ");
    return value;
  }
  Future<List> fetchTemplateID(String id) async {
    var dbClient = await dbSystem;
    String query = "SELECT * FROM DEFINITION WHERE template LIKE '%$id%' ";
    var res = await dbClient.rawQuery(query);
    return  res;
  }

  Future<List> fetchWorkSpaceData(String id) async {
    var dbClient = await dbSystem;
    String query = "SELECT * FROM WORKSPACE WHERE wsId = '$id' ";
    var res = await dbClient.rawQuery(query);
    return  res;
  }
  Future<void> createTable(String tableName, String columnName, String columnDataType) async {
		var dbClient = await dbContent;
  await dbClient.execute('CREATE TABLE IF NOT EXISTS $tableName($columnName $columnDataType)');
	}
  Future<void> addColumnToTable(String tableName, String columnName, String columnDataType) async {
		var dbClient = await dbContent;
    //TODO: remove hard coded columnName
    if(columnName == "group") {columnName = "groups";}
		await dbClient.execute('ALTER TABLE $tableName ADD $columnName $columnDataType;');
    // await dbClient.execute('ALTER TABLE $tableName ADD PRIMARY KEY $columnName $columnDataType;');
	}
  Future<dynamic> checkIfTableExist(String tableName, bool isSystemDatabase) async {
    var dbClient;
    if(isSystemDatabase==true) {
      dbClient = await dbSystem;
    }else {dbClient = await dbContent;}
		var result = await dbClient.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return result.length;
	}
  
  Future<List> fetchButtonData(String wsId, String containerId, String templateId) async {
    var dbClient = await dbSystem;
    var res = await dbClient.rawQuery("SELECT * FROM NAVIGATION_MAPPING WHERE wsId IS '$wsId' AND containerId IS '$containerId' AND templateId IS '$templateId'");
    return res.toList();
  }

  Future<void> createContentTable(String tableName, List<String> columnNames, List<String> columnDataTypes, List<String> primaryKey) async {
    String query = "CREATE TABLE IF NOT EXISTS $tableName(";
    var dbClient = await dbContent;
    String pkColumnName;
    for(int i=0;i<columnNames.length;i++) {
      var columnNamebuf = columnNames[i];
      var dataTypeBuf = columnDataTypes[i];
      if(columnNamebuf == "group") {columnNamebuf = "groups";}
      if(i==columnNames.length-1) {
        query += "$columnNamebuf $dataTypeBuf";
        if(primaryKey.length>0) {
          query += ", PRIMARY KEY (";
          for(int c=0;c<primaryKey.length;c++) {
            pkColumnName = primaryKey[c];
            if(c==primaryKey.length-1) {
              query += "$pkColumnName)";
            }else {query += "$pkColumnName,";}
          }
        }
        query += ")";
      }else {query += "$columnNamebuf $dataTypeBuf,";}
    }
    dbClient.execute(query);
  }
  Future<List> fetchColumnData(String tableName) async {
    var dbClient = await dbContent;
    var res = await dbClient.rawQuery("SELECT name FROM PRAGMA_TABLE_INFO('$tableName')");
    return res.toList();
  }

  Future<dynamic> isColumnExistInTable(String tableName,String columnName) async {
    var dbClient = await dbContent;
    var res = await dbClient.rawQuery("SELECT name FROM PRAGMA_TABLE_INFO('$tableName') WHERE name = '$columnName'");
    return res.length;
  }
  Future<void> updateTableColumn(String tableName, dynamic value,String columnName, bool isSystemDatabase, {dynamic interimId = 12345}) async {
    var dbClient;
    if(isSystemDatabase==true) {dbClient=await dbSystem;}else {dbClient=await dbContent;}
    await dbClient.rawQuery("UPDATE $tableName SET $columnName = '$value' WHERE id='$interimId'");
  }
  Future<String> fetchLabelFromGV(String defaultValue) async {
    var dbClient = await dbSystem;
    var res = await dbClient.rawQuery("SELECT value FROM GLOBALVARIABLE WHERE KEY IS '$defaultValue'");
    return res[0]['value'];
  }
  Future<String> getTextFieldLabel( dynamic key, {String localization = 'en-us'}) async {
    //TODO: create a global variable for localization (multi-lingual)
    var dbClient = await dbSystem;
    var res =await dbClient.rawQuery("SELECT * FROM LABEL WHERE key = '$key' AND localization = '$localization'");
    if(res.isEmpty==false) {
      return res[0]['value'];
    }else {
      return key;
    }
  }
  Future<List> fetchDataSourceData(dynamic dataSource) async {
    var dbClient = await dbContent;
    var res;
    if(dataSource[0]['filters'].length!=0) {
      String query = " WHERE ";
      for(int i=0;i<dataSource[0]['filters'].length;i++) {
        query += "${dataSource[0]['filters'][i]['key']} = '${dataSource[0]['filters'][i]['value']}'";
        if(i != dataSource[0]['filters'].length-1 || i!=0) query += " AND ";
      }
      if(dataSource[0]['sorting'].length!=0) {
        var order;
        if(dataSource[0]['sorting'][0]['reverse']==true) order = ' DESC';
        else order = ' ASC';
        query += " ORDER BY ${dataSource[0]['displayMember']}"+order;
      }
      await dbClient.rawQuery("SELECT * FROM ${dataSource[0]['entityName'].toUpperCase()}"+query).then((result) {
      res =result.toList();
      });
    }else {
      await dbClient.rawQuery("SELECT * FROM ${dataSource[0]['entityName'].toUpperCase()}").then((result) {
        res =result.toList();
      });
    }
    return res;
  }

  Future<List> checkIfPkExist(String tableName) async {
    var dbClient = await dbContent;
    var res = await dbClient.rawQuery("PRAGMA table_info ($tableName)");
    return res.toList();
  }

  Future<String> getUserName(int userId) async {
    var dbClient = await dbSystem;
    var res = await dbClient.rawQuery("SELECT * FROM USER WHERE userId = '$userId'");
    if(res.isEmpty==true) return "";
    else return res[0]['firstName'];
  }
  Future<List> getListingResults(String table,String query,dynamic searchAttributes) async {
    var dbClient = await dbContent;
    String sqlQuery = " ";
    if (searchAttributes.length != 0) {
      for (int i = 0; i < searchAttributes.length; i++) {
        sqlQuery += searchAttributes[i] + ' LIKE ' + '"\%$query%\"';
        if (i != searchAttributes.length - 1)
          sqlQuery += ' OR ';
      }
    }
        if (query == "") {
          var res = await dbClient.rawQuery(" SELECT * FROM $table");
          return res.toList();
        }

        else {
          var res = await dbClient.rawQuery(
              " SELECT * FROM $table WHERE $sqlQuery");
          return res.toList();
        }
  }
  Future<String> getListingLabel(String tableName,String columnName , dynamic value ,String displayColumn) async {
    var dbClient = await dbContent;
    var res = await dbClient.rawQuery("SELECT $displayColumn FROM $tableName WHERE $columnName = '$value' ");
     return res[0]['name'];
  }
}