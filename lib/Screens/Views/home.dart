import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Models/models.dart';
import 'package:jupiter/List/listingView.dart';
import 'package:jupiter/Screens/CustomViews/progress_indicator.dart';
import 'package:jupiter/Screens/Views/forgot_password.dart';
import 'package:jupiter/forms/main.dart';
import 'package:jupiter/forms/list.dart';
import 'dev_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
var navigationData;
List<dynamic> buttons = [];
String wsId;

class Menus extends StatefulWidget {

  static const rootName = '/menus';

  @override _MenusState createState() => _MenusState();
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
                  accountName: new Text(""),
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
                                          onTap: () async{
                                            await _workSpaceData(snapshot.data[position]['wsId'].toString());
                                            wsId = snapshot.data[position]['wsId'].toString();
                                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                            sharedPreferences.setString("wsId", wsId);
                                            Navigator.push(context,MaterialPageRoute(builder: (context) =>MyApp()));
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Progress()));
                                            await Future.delayed(Duration(seconds: 1));
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Menus()));
                                            // Navigator.push(context,MaterialPageRoute(builder: (context) =>MyApp()));
                                            Navigator.push(context,MaterialPageRoute(builder: (context) =>MyApp(),fullscreenDialog: true));
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ListingView()));
                        })),
              ])),
        ));
  }
  _workSpaceData(String wsId)async{
    var db = new DatabaseHelper();
    var res = await db.fetchWorkSpaceData(wsId);
//    print(res[0]['defaultTemplateId']);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("TemplateId",res[0]['defaultTemplateId'] );
  }
}

void checkIfButtonsAreFetched(context) async {
  if(buttons.length>0) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }
  else {
    checkIfButtonsAreFetched(context);
  }
}