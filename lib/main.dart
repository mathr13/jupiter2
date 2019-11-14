import 'package:flutter/material.dart';
import 'package:jupiter/Routes/routes.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/firebaseFunctions.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';

String baseUrl = "";
String summaryData = "";
bool isFirstLogin = true;
List<Map> fetchedSystemTableData = [];
List<String> fetchedContentTableData = [];

void main() async {
  var db = DatabaseHelper();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if(sharedPreferences.containsKey("FirstTimeLogin")==true && sharedPreferences.get("FirstTimeLogin")==false) {
    contentDb = sharedPreferences.getString("contentDb");
    var buffer = await db.fetchTablesData(false);
    userName = sharedPreferences.get("userName");
    for(int i=0;i<buffer.length;i++) {fetchedContentTableData.add(buffer[i]['name']);}
    isFirstLogin = false;
  }
 await db.dbSystem;
  fetchedSystemTableData = await db.fetchTablesData(true);
  baseUrl = await remoteConfig();
  summaryData = await summaryRemoteConfig();
  runApp(new FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Login App',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: routes,
    );
  }
}