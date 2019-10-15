import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Screens/Views/forgot_password.dart';
import 'package:jupiter/forms/main.dart';
import 'dev_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
var navigationData;
List<String> buttons = [];

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
                                          onTap: () async{
                                            {
                                                // await _workSpaceData(snapshot.data[position]['wsId'].toString());
                                                // Navigator.push(context,MaterialPageRoute(builder: (context) =>MyApp()));

                                              if (position == 0) {
                                                Navigator.push(context,MaterialPageRoute(builder: (context) =>MyApp()));
                                              }else {
                                                getButtonData();
                                                await Future.delayed(Duration(seconds: 2));
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

void getButtonData() async {
  buttons = await db.fetchButtonData();
  print("buttons");
}



class GenericMenuPage extends StatefulWidget {
  @override _GenericMenuPageState createState() => _GenericMenuPageState();
}

class _GenericMenuPageState extends State<GenericMenuPage> {
  @override Widget build(BuildContext context) {
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
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            print(buttons[index]);
            return ListTile(
              title: Text("label"),
            );
          },
        )
      ),
    );
  }
}