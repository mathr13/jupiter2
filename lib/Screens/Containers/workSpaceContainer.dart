import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/List/listingView.dart';
import 'package:jupiter/Screens/Views/forgotPassword.dart';
import 'package:jupiter/Screens/Views/profile.dart';
import 'package:jupiter/forms/formRendering.dart';
import 'package:jupiter/Screens/Views/devTools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jupiter/Screens/Views/home.dart';
var navigationData;
String wsId;
int _currentSelected = 0;
String userName = "user";
ScrollController _scrollController = new ScrollController();
final db = new DatabaseHelper();
bool dynamicMenus = false;


class WorkSpaceContainer extends StatefulWidget {
  final String titleString;
  WorkSpaceContainer({this.titleString});
  @override _WorkSpaceContainerState createState() => _WorkSpaceContainerState();
}

class _WorkSpaceContainerState extends State<WorkSpaceContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleString),
      ),
      drawer: menuDrawer(context),
    );
  }

  _workSpaceData(String wsId) async {
    var db = new DatabaseHelper();
    var res = await db.fetchWorkSpaceData(wsId);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("TemplateId", res[0]['defaultTemplateId']);
  }

  Widget menuDrawer(context) {
    String nameInititals = userName[0];
    for (int i = 1; i < userName.length; i++) {
      if (i != userName.length - 1 && userName[i] == " ")
        nameInititals += userName[i + 1];
    }
    return Drawer(
        child: Column(
            children: <Widget>[
              new Container(
                  child: new UserAccountsDrawerHeader(
                    arrowColor: Colors.transparent,
                    accountEmail: new Text(emailController.text),
                    accountName: new Text(userName),
                    currentAccountPicture: new CircleAvatar(
                      backgroundColor: Colors.lightGreen,
                      child: new Text(nameInititals),
                    ),
                    onDetailsPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => new Profile()));
                    },
                  )
              ),
              Expanded(
                child: new ListView(children: <Widget>[
                  FutureBuilder<List>(
                    future: db.fetchMenuData(),
                    initialData: List(),
                    builder: (context, snapshot) {
                      return snapshot.hasData ? ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length + 3,
                        itemBuilder: (_, int position) {
                          return new InkWell(
                              child: menuItem(position, context, snapshot,
                                  snapshot.data.length)
                          );
                        },
                      ) : Center(child: CircularProgressIndicator());
                    },
                  ),
                ]),
              )
            ]
        )
    );
  }

  Widget menuItem(int position, context, snapshot, int menuItems) {
    if (position == 0) {
      return new Container(
          color: _currentSelected == position ? Colors.green : Colors
              .transparent,
          child: ListTile(
              title: Container(child: Text("Summary")),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Menus()));
                _currentSelected = position;
                dynamicMenus = false;
                SharedPreferences sharedPreferences = await SharedPreferences
                    .getInstance();
                userName = sharedPreferences.get("userName");
              }
          )
      );
    } else if (position == 1) {
      return new Container(
          color: _currentSelected == position ? Colors.green : Colors
              .transparent,
          child: ListTile(
            title: Container(child: Text("Dev Tools")),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new DevTools()));
              dynamicMenus = false;
              _currentSelected = position;
            },
          )
      );
    } else if (position == menuItems + 2) {
      return new Container(
          color: _currentSelected == position ? Colors.green : Colors
              .transparent,
          child: ListTile(
              title: Container(child: Text(" LOGOUT")),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListingView()));
                _currentSelected = position;
                dynamicMenus = false;
              }
          )
      );
    } else {
      return new Container(
        color: _currentSelected == position ? Colors.green : Colors.transparent,
        child: ListTile(
            title: Container(
                child: Text(snapshot.data[position - 2]["value"].toString())
            ),
            onTap: () async {
              await _workSpaceData(
                  snapshot.data[position - 2]['wsId'].toString());
              wsId = snapshot.data[position - 2]['wsId'].toString();
              SharedPreferences sharedPreferences = await SharedPreferences
                  .getInstance();
              sharedPreferences.setString("wsId", wsId);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  WorkSpaceContainer(
                    titleString: snapshot.data[position - 2]["value"]
                        .toString(),)));
              formTitle = snapshot.data[position - 2]["value"].toString();
              _currentSelected = position;
              dynamicMenus = true;
            }
        ),
      );
    }
  }
}