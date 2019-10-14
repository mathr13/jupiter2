import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Screens/Views/forgot_password.dart';
import 'package:jupiter/forms/main.dart';
import 'dev_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

var navigationData;

class Menus extends StatefulWidget {
  @override
  _MenusState createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  ScrollController _scrollController = new ScrollController();
  int _currentSelected = 0;
  final db = new DatabaseHelper();

  @override Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(title: Text("Menus")),
          drawer: Drawer(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                new Container(
                    child: new UserAccountsDrawerHeader(
                  accountEmail: new Text(emailController.text),
                  accountName: new Text("Abc"),
                  currentAccountPicture: new CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    child: new Text("ab"),
                  ),
                )),
                new Container(
                    child: ListTile(
                        title: Container(child: Text("Dev Tools")),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => new DevTools()));
                        })),
                Expanded(
                  child: new ListView(children: <Widget>[
                    FutureBuilder<List>(
                      future: db.fetchMenuData(),
                      initialData: List(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (_, int position) {
                                  return new InkWell(
                                    child: new Container(
                                      color: _currentSelected == position
                                          ? Colors.green
                                          : Colors.white,
                                      child: ListTile(
                                          title: Container(
                                            child: Text(snapshot.data[position]
                                                    ["value"]
                                                .toString()),
                                          ),
                                          onTap: () {
                                            {
                                              if (position == 0) {
                                                _saveTemplateId();
                                                Navigator.push(context,MaterialPageRoute(builder: (context) =>MyApp()));
                                              }else {
                                                var data = '[{"templateId":"Save Item","buttonId":"save","componentType":"button","componentSubType":"button","redirectTemplateId":"List Item","label":"save","operation":"save","containerId":"P1"},{"templateId":"Save Item","buttonId":"close","componentType":"button","componentSubType":"button","redirectTemplateId":"Dashboard","label":"close","operation":"close","containerId":"P1"}]';
                                                navigationData = json.decode(data);
                                                Navigator.push(context,MaterialPageRoute(builder: (context) =>GenericMenuPage()));
                                              }
                                            }
                                            setState(() {
                                              _currentSelected = position;
                                            });
                                          }
                                          // snapshot.data[position]["menuId"].toString()),
                                          // snapshot.data[position].runtimeType.toString()),
                                          ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ]),
                ),
                new Container(
                    child: ListTile(
                        title: Container(child: Text(" LOGOUT")),
                        onTap: () {
//                Navigator.push(
//                    context, MaterialPageRoute(builder: (context) => DevTools()));
                        })),
              ])),
        ));
  }
  _saveTemplateId()async{

              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("TemplateID", '295737f6-70fd-42cc-a066-c6fe1529ca5f');

  }
}



class GenericMenuPage extends StatefulWidget {
  @override _GenericMenuPageState createState() => _GenericMenuPageState();
}

class _GenericMenuPageState extends State<GenericMenuPage> {
  @override Widget build(BuildContext context) {
    List<String> buttons = ["one","do"];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {Navigator.pop(context);},
        ),
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: buttons.length,
          itemBuilder: (context,index) {
            return ListTile(
              title: Text(navigationData[index]['label']),
            );
          },
        )
      ),
    );
  }
}