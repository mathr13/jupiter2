//
//import 'package:flutter/material.dart';
//import 'package:jupiter/Screens/Views/home.dart';
//import 'package:jupiter/forms/formRenderedElements.dart';
//import 'dart:convert';
//import 'package:jupiter/Databasehelper/databaseHelper.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:core';
//import 'jsondata.dart';
//import 'package:jupiter/Screens/Views/troy.dart';
//
//
//Object obj;
//String formTitle=" ";
//var res;
//List<Map> listOfHierarchy = [{}];
//Map mapOfPrimaryKeys ={};
//dynamic formValue;
//
//class MyApp extends StatelessWidget {
//  @override Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () async {
//        return true;
//      },
//      child: App(),
//    );
//  }
//}
//
//class App extends StatefulWidget {
//  App({this.formItems});
//  final dynamic formItems;
//
//  @override _AppState createState() => _AppState();
//}
//
//class _AppState extends State<App> {
//  void initState(){
//    super.initState();
//  }
//
//  @override Widget build(BuildContext context) {
//    return new MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primarySwatch: Colors.green
//      ),
//      home:Scaffold(
//        drawer: menuDrawer(context),
//        appBar: new AppBar(
//          title: new Text(formTitle),
//        ),
//        body: new SingleChildScrollView(
//          child: new Container(
//            child: new Column(children: <Widget>[
//              FutureBuilder<dynamic>(
//                future: _getTemplateId(),
//                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                  if (!snapshot.hasData) return CircularProgressIndicator();
//                  return CoreForm(
//                    form:formValue.toString(),
//                    jsonForm: listingData.toString(),
//                    //res[0]['template'],
//                  );
//                }
//              )
//            ]),
//          ),
//        ),
//      )
//    );
//  }
//
//
//  String message(){
//    int i;
//    String msg=' ';
//    dynamic formItems=json.decode(json.encode("hjk"));
//    for( i=0;i<formItems.length;i++) {
//      if (formItems[i]['type'] == 'text') {
//        if (formItems[i]['response']== ""||formItems[i]['response']== null)
//        {
//          msg= msg + formItems[i]['id'] + ' cannot be empty \n';
//          print(msg);
//        }
//      }
//    }
//    if(msg==" ")
//      return msg;
//    else {
//       _showDialog(msg);
//       return msg;
////  ShowAlert(message: msg,);
//      // ShowAlert(message: msg,);
//    }
//  }
//  void _showDialog(String message) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: new Text("Error!"),
//          content: new Text(message ,style:new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Close",style:new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//}
//
//_getTemplateId() async {
//  var db = new DatabaseHelper();
//  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//  String id= sharedPreferences.get('TemplateId');
//  res=  await db.fetchTemplateID(id);
//  //TODO: REVERT RETURN
//  return res[0]['template'].toString();
//}

import 'package:flutter/material.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'dart:convert';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:jupiter/Screens/Views/troy.dart';


Object obj;
var res;
List<Map> listOfHierarchy = [{}];
Map mapOfPrimaryKeys ={};
dynamic formValue;
bool isUpdateTrue=false;
String primaryKey="";

class App extends StatefulWidget {
  App({this.formItems,this.isEditTrue,this.defaultData,this.isDrawerTrue,this.formTitle});
  final dynamic formItems;
  final bool isEditTrue;
  final dynamic defaultData;
  String formTitle;
  bool isDrawerTrue;

  @override _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  void initState(){
    super.initState();
  }

  @override Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green
        ),
        home:Scaffold(

          drawer:widget.isDrawerTrue==true?
          menuDrawer(context):null,
          appBar: new AppBar(
            leading: widget.isDrawerTrue==true?null:IconButton(icon: Icon(Icons.arrow_back_ios,),onPressed: (){
              Navigator.pop(context);
            },),
            title: new Text(widget.formTitle),
          ),
          body: FutureBuilder<dynamic>(
              future: _getTemplateId(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return Gridxo(defiData: snapshot.data.toString(),);
              }
          )
        )
    );
  }


  String message(){
    int i;
    String msg=' ';
    dynamic formItems=json.decode(json.encode("hjk"));
    for( i=0;i<formItems.length;i++) {
      if (formItems[i]['type'] == 'text') {
        if (formItems[i]['response']== ""||formItems[i]['response']== null)
        {
          msg= msg + formItems[i]['id'] + ' cannot be empty \n';
          print(msg);
        }
      }
    }
    if(msg==" ")
      return msg;
    else {
      _showDialog(msg);
      return msg;
//  ShowAlert(message: msg,);
      // ShowAlert(message: msg,);
    }
  }
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error!"),
          content: new Text(message ,style:new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",style:new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

_getTemplateId() async {
  var db = new DatabaseHelper();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String id= sharedPreferences.get('TemplateId');
  res=  await db.fetchTemplateID(id);
  //TODO: REVERT RETURN
  return res[0]['section'].toString();
}