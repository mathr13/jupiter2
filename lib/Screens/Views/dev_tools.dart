import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Services/firebaseFunctions.dart';

import '../../main.dart';

List<String> _tablesData = [];
String dropdownValue;
List<Map> bufferList;
Widget buildbody = null;
bool buffer = true;
var count;
var data ;
ScrollController _scrollController = new ScrollController();
var db = new DatabaseHelper();

class DevTools extends StatefulWidget {
  @override _DevToolsState createState() => _DevToolsState();
}

void getDataOfTables(bool isSystemDatabase) {
  if(isSystemDatabase==true) {
    for(int i=0;i<fetchedSystemTableData.length;i++) {
      _tablesData.add(fetchedSystemTableData[i]['name']);
    }
  }else {_tablesData.addAll(fetchedContentTableData);}
}

// Future getDataOfSystemTable() async {
//   bufferList = await db.fetchTablesData();
//   await Future.delayed(Duration(seconds: 2));
//    for(int i=0;i<bufferList.length;i++) {
//     _tablesData.add(bufferList[i]['tableName']);
//   }
// }

class _DevToolsState extends State<DevTools> {
  String databaseCheck = "System";
  @override Widget build(BuildContext context) {
    if(_tablesData.length==0) {
      if(databaseCheck!="System") {
        buffer = false;
      }
      getDataOfTables(buffer);
    }
    return WillPopScope(
      onWillPop: () async {
        dropdownValue = null;
        return true;
      },
      child: Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text(databaseCheck),
              onPressed: () {
                setState(() {
                  if(databaseCheck=="System") {
                    databaseCheck = contentDb;
                    _tablesData.clear();
                    buffer = false;
                    dropdownValue = null;
                    getDataOfTables(buffer);
                  }else {
                    databaseCheck = "System";
                    _tablesData.clear();
                    buffer = true;
                    dropdownValue = null;
                    getDataOfTables(buffer);
                  }
                });
              },
            )
          ),
          DropdownButton<String>(
            value: dropdownValue,
            items: _tablesData.map((String value) => DropdownMenuItem<String>(
              child: Text(value),
              value: value,
            )).toList(),
            onChanged: (String newValue) async {
              var db = new DatabaseHelper();
              data = await db.fetchData(newValue,buffer);
              count = await db.count(newValue,buffer);
              setState(() {
                dropdownValue = newValue;
                buildbody = form();
              });
            },
            isExpanded: false,
            hint: Text('Select'),
          ),
          Container(
            child:buildbody
          )
        ]
      ),
      )
    ),
    );
  }

  Widget form() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Count = '+ count[0]['COUNT(1)'].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: count[0]['COUNT(1)'],
            itemBuilder: (context, int index) {
              return new ListTile(
                title:Text(data[index].toString(),
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))
              );
            }
          ),
        ],
      )
    );
  }
}