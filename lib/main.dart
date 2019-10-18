import 'package:flutter/material.dart';
import 'package:jupiter/Routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/firebaseFunctions.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';

String baseUrl = "";
bool isFirstLogin = true;
List<Map> fetchedSystemTableData = [];
List<String> fetchedContentTableData = [];

void main() async {
  var db = DatabaseHelper();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if(sharedPreferences.containsKey("FirstTimeLogin")==true && sharedPreferences.get("FirstTimeLogin")==false) {
    contentDb = sharedPreferences.getString("contentDb");
    var buffer = await db.fetchTablesData(false);
    for(int i=0;i<buffer.length;i++) {fetchedContentTableData.add(buffer[i]['name']);}
    isFirstLogin = false;
  }
 await db.dbSystem;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new FlutterApp());
  });
  fetchedSystemTableData = await db.fetchTablesData(true);
  baseUrl = await remoteConfig();
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