import 'package:flutter/material.dart';
import 'package:jupiter/Routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/firebaseFunctions.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';

String baseUrl = "";
bool isFirstLogin = true;

void main() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if(sharedPreferences.containsKey("FirstTimeLogin")==true && sharedPreferences.get("FirstTimeLogin")==false) {
    isFirstLogin = false;
  }
  var db = DatabaseHelper();
 await db.dbSystem;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new FlutterApp());
  });
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