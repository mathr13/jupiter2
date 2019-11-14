
import 'package:flutter/material.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'dart:convert';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:jupiter/forms/jsondata.dart';
import 'package:jupiter/hierarchyFormRendering/parentSection.dart';
String formTitle=" ";
var res;
List<Map> listOfHierarchy = [{}];
Map mapOfPrimaryKeys ={};
dynamic formValue;

class FormRender extends StatefulWidget {
  FormRender({this.formItems});
  final dynamic formItems;

  @override _FormState createState() => _FormState();
}

class _FormState extends State<FormRender> {
  void initState() {
    super.initState();
  }

  @override Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green
        ),
        home: Scaffold(
          drawer: menuDrawer(context),
          appBar: new AppBar(
            title: new Text(formTitle),
          ),
          body: new SingleChildScrollView(
            child: new Container(
              child: new Column(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: <Widget>[
                FutureBuilder<dynamic>(
                    future: _getTemplateId(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return ParentSection(
                        formData: listingData.toString(),
                        //res[0]['template'],
                      );
                    }
                )
              ]),
            ),
          ),
        )
    );
  }


  _getTemplateId() async {
    var db = new DatabaseHelper();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.get('TemplateId');
    res = await db.fetchTemplateID(id);
    return res[0]['formId'].toString();
  }
}