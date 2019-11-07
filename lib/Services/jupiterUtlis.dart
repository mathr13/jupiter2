import 'dart:convert';
import 'package:jupiter/Constant/stringConstant.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Models/user.dart';
import 'package:jupiter/Models/models.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/Screens/Views/signIn.dart';
import 'package:jupiter/Services/jupiterServices.dart';
import 'package:jupiter/Screens/CustomViews/alert.dart';
import 'package:flutter/material.dart';
import 'package:jupiter/Screens/CustomViews/progressIndicator.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future, Timer;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'firebaseFunctions.dart';

String finalUrl = "";
List<Map> checkNotificationData;
List<Map> fetchedProjectFromNotificationData = [];

void authenticate(context) async {
  User user = User(
    // userName: emailController.text,
    // password: passwordController.text,
    // userName: "usharma@petroitg.com",
    // password: "India@123"
    // userName: "piku@gmail.com",
    // password: "piku@gmail.com"
    userName: "superman@mailinator.com",
    password: "India@123",
    // userName: "sojha@petroitg.com",
    // password: "sumi"
  );
  fetchUserApi(user).then((userDataResponse) async {
    var db = new DatabaseHelper();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonUserResponse = json.decode(userDataResponse.body);
    if (jsonUserResponse[statusApi][messageCodeApi] == 1200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Progress()));
      AuthenticationObject authObject =
          new AuthenticationObject.fromJson(jsonUserResponse);
      sharedPreferences.setInt('userId', authObject.data.userId);
      userName = authObject.data.firstName + " " + authObject.data.lastName;
      sharedPreferences.setString("userName", authObject.data.firstName);
      db.populateTableWithMapping(userTable, authObject.data.toMap(), true);
    } else {
      dialog(wrongAuth, context);
    }

    // fetchedTableData = await db.fetchTablesData();

    getDatafromFirebase(context); //Get Notification Data From Firebase
    await Future.delayed(Duration(seconds: 1));

    fetchedProjectFromNotificationData =
        await db.getProjectIdFromNotificationData();
    if (fetchedProjectFromNotificationData.length == 0) {
      await Future.delayed(Duration(seconds: 5));
    }
    saveMasterData(fetchedProjectFromNotificationData); //Project Data
    await Future.delayed(Duration(seconds: 5));
    getProjectData(); //Menu, Label, Permission, etc Data
    // db.updateColumn(notificationTable, "status", "SYNC");
    await Future.delayed(Duration(seconds: 5));
    checkIfDataIsStored(context);

    int count = 0;
    Timer.periodic(Duration(seconds: 3), (timer) async {
      checkNotificationData =
          await db.checkIfNotificationReceived(notificationTable);
      count++;
      if (checkNotificationData.length > 0) {
        timer.cancel();
      } else if (count == 3) {
        timer.cancel();
        //TODO: ALERT BOX
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      }
    });
  }).catchError((error) {
    print('error3 : $error');
    dialog(wrongAuth, context);
  });
}

Future<http.Response> callApi(String url, String header) async {
  finalUrl = baseUrl;
  finalUrl += url;
  final response = await http.get(
    '$finalUrl',
    headers: {
      'Content-Type': contentHeader,
      'App-Type': appType,
      parameters: header,
      'cookie': finalCookies
    },
  );
  finalUrl = baseUrl;
  return response;
}

Future<http.Response> sendRequestWithParam(
    String url, String param, String requestType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String cookies = prefs.getString('cookie');

  finalUrl = url;
  if (requestType.toString() == RequestType.getRequest) {
    final response = await http.get(
      '$finalUrl',
      headers: {
        'Content-Type': contentHeader,
        'App-Type': appType,
        parameters: param,
        'cookie': cookies
      },
    );
    finalUrl = baseUrl;
    return response;
  }
  if (requestType.toString() == "Post") {
    final response = await http.post(
      '$finalUrl',
      headers: {
        'Content-Type': contentHeader,
        'App-Type': appType,
        'cookie': cookies
      },
      body: param
    );
    finalUrl = baseUrl;
    return response;
  }
}

void checkNull(context) {
  // if (passwordController.text.length == 0 && emailController.text.length == 0) {
  //   dialog(nullEmailPass, context);
  //   return null;
  // } else if (passwordController.text.length == 0) {
  //   dialog(nullPassword, context);
  //   return null;
  // } else if (emailController.text.length == 0) {
  //   dialog(nullEmail, context);
  //   return null;
  // } else {
  //   authenticate(context);
  // }
  authenticate(context);
}

/*
Future<void> saveParentWithChild(DatabaseHelper db, dynamic apexObject, dynamic columnName) async {
  for (int i = 0; i < apexObject.menuData.menus.length; i++) {
    db.populateTableWithMapping("Menu", apexObject.menuData.menus[i].toMap());
    for (int j = 0;j<apexObject.menuData.menus[i].sunMenuItems.length;j++) {
      db.populateTableWithCustomColumn(
        "Menu",
        apexObject.menuData.menus[i].sunMenuItems[j].toMap(),
        "parentId",
        apexObject.menuData.menus[i].menuId
      );
    }
    db.updateColumn("Menu", "projectId", columnName);
  }
}
Future<void> fetchPost() async {
  Map<String, String> headers = {"Content-type": "application/json"};
  String theBody = "{'UserToken': '59d4d2c5-45b5-4f96-a062-b2b3259ef241'}";
  http.Response response = await http.post('https://adaptor.pipetrakit.com/api/ImportData/getMetaData',
    headers: headers,
    body: theBody
  );
  final jsonResponse = json.decode(response.body);
  TopColumnObject topColumnObject = new TopColumnObject.fromJson(jsonResponse);

  DatabaseHelperProjects databaseHelperProjects = DatabaseHelperProjects();
  for (var i = 0;i<topColumnObject.data.formModels.length; i++) {
    for (var j = 0;j<topColumnObject.data.formModels[i].model.tables.length;j++) {
      databaseHelperProjects.createTable(
        topColumnObject.data.formModels[i].model.tables[j].tableName,
        topColumnObject.data.formModels[i].model.tables[j].columns[0].columnName,
        topColumnObject.data.formModels[i].model.tables[j].columns[0].dataType
      );
      for (var k = 1;k<topColumnObject.data.formModels[i].model.tables[j].columns.length;k++) {
        databaseHelperProjects.addColumnToTable(
          topColumnObject.data.formModels[i].model.tables[j].tableName,
          topColumnObject.data.formModels[i].model.tables[j].columns[k].columnName,
          topColumnObject.data.formModels[i].model.tables[j].columns[k].dataType
        );
      }
    }
  }
}
*/

class Styles {
  static const navigationTitle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "Verlag-Bold",
      letterSpacing: 1,
      fontStyle: FontStyle.normal,
      fontSize: 15);
  static const primaryText = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontFamily: "Lato-Regular",
      letterSpacing: 1,
      fontStyle: FontStyle.normal,
      fontSize: 15);
  static const summaryText = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: "Lato-Regular",
      letterSpacing: 1,
      fontStyle: FontStyle.normal,
      fontSize: 15);
}

class RequestType {
  static const getRequest = "Get";
  static const postRequest = "Post";
}
