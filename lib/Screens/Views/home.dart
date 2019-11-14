import 'package:flutter/material.dart';
import 'package:jupiter/Constant/stringConstant.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Screens/Views/forgotPassword.dart';
import 'package:jupiter/Screens/Views/profile.dart';
import 'package:jupiter/Screens/Views/troy.dart';
import 'package:jupiter/forms/formRendering.dart';
import 'package:jupiter/main.dart';
import 'devTools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jupiter/Screens/Containers/workSpaceContainer.dart';
import 'dart:convert';
import 'package:jupiter/Services/jupiterUtlis.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:jupiter/forms/formRendering.dart';
import 'devTools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jupiter/Screens/Containers/formsContainer.dart';
import 'package:jupiter/List/listingView.dart';

var navigationData;
String wsId;
int _currentSelected = 0;
String userName = "user";
ScrollController _scrollController = new ScrollController();
final db = new DatabaseHelper();
bool dynamicMenus = false;
final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
double abcd = 100;

class Menus extends StatefulWidget {
  static const rootName = '/menus';
  @override
  _MenusState createState() => _MenusState();
}



class _MenusState extends State<Menus> {
  @override
  Widget build(BuildContext context) {
    var summaryDataDecode = json.decode(summaryData);
    var jsonData = [];
    jsonData = summaryDataDecode["summaryData"];
    List _summaryListViewData =
        jsonData.where((lang) => lang["language"] == "en_US").toList();
    return new WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(title: Text("SUMMARY", style: Styles.navigationTitle)),
          drawer: menuDrawer(context),
          body: new ListView.builder(
              itemCount: _summaryListViewData == null
                  ? 0
                  : _summaryListViewData.length,
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  onTap: (){
                    Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(_summaryListViewData[index]["labelName"].toString()),
                              ));
                  },
                  //You need to make my child interactive


                  child: new Card(
                    //I am the clickable child
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          child: Container(
                            color: Colors.grey,
                            width: 5,
                          ),
                          width: 10,
                          margin: const EdgeInsets.only(right: 10),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          child: Text(
                            (index * 2 + 1).toString() +
                                " " +
                                _summaryListViewData[index]["labelName"]
                                    .toUpperCase(),
                            style: Styles.summaryText,
                            textAlign: TextAlign.center,
                          ),
                          alignment: Alignment.center,
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}

// Logout user
Future<bool> logoutUser() async {
  var isLogoutSucess = false;
  String firebaseToken = await firebaseMessaging.getToken();
  dynamic responseApi;
  responseApi = await sendRequestWithParam(
      baseUrl + logOutUrl,
      '{"firebaseToken": "$firebaseToken"}',
      RequestType.postRequest.toString());
  final result = json.decode(responseApi.body);
  if (result["status"]["messageCode"] == 1200) {
    isLogoutSucess = true;
  } else {
    isLogoutSucess = false;
  }
  return isLogoutSucess;
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
      child: Column(children: <Widget>[
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Profile()));
      },
    )),
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
                    itemCount: snapshot.data.length + 3,
                    itemBuilder: (_, int position) {
                      return new InkWell(
                          child: menuItem(position, context, snapshot,
                              snapshot.data.length));
                    },
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ]),
    )
  ]));
}

Widget menuItem(int position, context, snapshot, int menuItems) {
  if (position == 0) {
    return new Container(
      color: _currentSelected == position ? Colors.green : Colors.transparent,
      child: ListTile(
        title: Container(child: Text("Summary")),
        onTap: () async {
          // Navigator.push(context,MaterialPageRoute(builder: (context) => new Menus()));
          // while(checkerForGridHeight==0) {
          //   print(keys);
          //   checkerForGridHeight = getSizes(keys[counterCounter]);
          // }
          Navigator.push(context,MaterialPageRoute(builder: (context) => new Gridxo()));
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new DevTools()));
            dynamicMenus = false;
            _currentSelected = position;
          },
        ));
  } else if (position == menuItems + 2) {
    return new Container(
      color: _currentSelected == position ? Colors.green : Colors.transparent,
      child: ListTile(
        title: Container(child: Text(" LOGOUT")),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FormContainer()));
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
          await _workSpaceData(snapshot.data[position - 2]['wsId'].toString());
          wsId = snapshot.data[position - 2]['wsId'].toString();
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          sharedPreferences.setString("wsId", wsId);
          if (snapshot.data[position - 2]["value"] == 'Inventory') {
            var res;
            _getTemplateId() async {
              var db = new DatabaseHelper();
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              String id= sharedPreferences.get('TemplateId');
              res=  await db.fetchTemplateID(id);
              //TODO: REVERT RETURN
              return res[0]['section'].toString();
            }
            await _getTemplateId().then((list){
              Navigator.push(context,MaterialPageRoute(builder: (context) =>ListingView(listData: list,label:res[0]['formLabel'].toString(),)));

            });

          }
          else {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                App(isEditTrue: false,
                  isDrawerTrue: true,
                  formTitle: snapshot.data[position - 2]["value"].toString(),)
              //    WorkSpaceContainer(titleString: snapshot.data[position-2]["value"].toString(),)
            ));
            _currentSelected = position;
            dynamicMenus = true;
          }
        }
      ),
    );
  }
}