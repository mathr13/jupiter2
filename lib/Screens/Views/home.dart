import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Models/models.dart';
import 'package:jupiter/List/listingView.dart';
import 'package:jupiter/Screens/CustomViews/progress_indicator.dart';
import 'package:jupiter/Screens/Views/forgot_password.dart';
import 'package:jupiter/Screens/Views/profile.dart';
import 'package:jupiter/forms/main.dart';
import 'package:jupiter/forms/list.dart';
import 'dev_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';


var navigationData;
String wsId;
int _currentSelected = 0;
String userName = "user";
ScrollController _scrollController = new ScrollController();
final db = new DatabaseHelper();
bool dynamicMenus = false;

class Menus extends StatefulWidget {
  static const rootName = '/menus';
  @override _MenusState createState() => _MenusState();
}

class _MenusState extends State<Menus> {

  @override Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("SUMMARY")),
        drawer: menuDrawer(context)
      )
    );
  }
}


_workSpaceData(String wsId) async {
  var db = new DatabaseHelper();
  var res = await db.fetchWorkSpaceData(wsId);
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("TemplateId", res[0]['defaultTemplateId']);
}


Widget menuDrawer(context) {
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
              child: new Text("ab"),
            ),
            onDetailsPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => new Profile()));},
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
                  itemCount: snapshot.data.length+3,
                  itemBuilder: (_, int position) {
                    return new InkWell(
                      child: menuItem(position, context, snapshot, snapshot.data.length)
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
  if(position==0){
    return new Container(
      color: _currentSelected == position ? Colors.green : Colors.transparent,
      child: ListTile(
        title: Container(child: Text("Summary")),
        onTap: () async {
          Navigator.push(context,MaterialPageRoute(builder: (context) => new Menus()));
          _currentSelected = position;
          dynamicMenus = false;
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          userName = sharedPreferences.get("userName");
        }
      )
    );
  }else if(position==1) {
    return new Container(
      color: _currentSelected == position ? Colors.green : Colors.transparent,
      child: ListTile(
        title: Container(child: Text("Dev Tools")),
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => new DevTools()));
          dynamicMenus = false;
          _currentSelected = position;
        },
      )
    );
  }else if(position==menuItems+2) {
    return new Container(
      color: _currentSelected == position ? Colors.green : Colors.transparent,
      child: ListTile(
        title: Container(child: Text(" LOGOUT")),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DevTools()));
          _currentSelected = position;
          dynamicMenus = false;
        }
      )
    );
  }else {
    return new Container(
      color: _currentSelected == position ? Colors.green : Colors.transparent,
      child: ListTile(
        title: Container(
          child: Text(snapshot.data[position-2]["value"].toString())
        ),
        onTap: () async {
          await _workSpaceData(snapshot.data[position-2]['wsId'].toString());
          wsId = snapshot.data[position-2]['wsId'].toString();
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("wsId", wsId);
          Navigator.push(context,MaterialPageRoute(builder: (context) =>MyApp()));
          formTitle = snapshot.data[position-2]["value"].toString();
          _currentSelected = position;
          dynamicMenus = true;
        }
      ),
    );
  }
}