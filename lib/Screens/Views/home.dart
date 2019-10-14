import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Screens/Views/forgot_password.dart';
import 'package:jupiter/forms/main.dart';
import 'dev_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jupiter/Models/models.dart';

class Menus extends StatefulWidget {
  @override
  _MenusState createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  ScrollController _scrollController = new ScrollController();
  int _currentSelected = 0;
  final db = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new DevTools()));
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
                                          onTap: () async{
                                            {
                                                await _workSpaceData(snapshot.data[position]['wsId'].toString());
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyApp()));

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
  _workSpaceData(String wsId)async{
    var db = new DatabaseHelper();
    var res = await db.fetchWorkSpaceData(wsId);
//  NavigationMapping navigationMapping = new NavigationMapping.fromJson(res[0]);
//print(navigationMapping.containerId);
    print(res[0]['defaultTemplateId']);
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("TemplateID", res[0]['defaultTemplateId']);

  }
}
