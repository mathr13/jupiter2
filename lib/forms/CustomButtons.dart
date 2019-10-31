import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:uuid/uuid.dart';

var db = DatabaseHelper();
dynamic interimId;
Map<String, dynamic> transQData = {'transQueueId': '', 'requestId': '', 'requestData': '', 'lookUpData': '','projectId': '','userId': '', 'status': '', 'syncStatus': '', 'conflicts': '', 'responseData': '', 'wsId': '', 'createdData': '', 'updateData': ''};

class CustomButton extends StatefulWidget {
  final String wsId;
  final Map item;
  final List<dynamic> buttons;

  CustomButton({@required this.buttons,this.wsId,this.item});

  @override _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override Widget build(BuildContext context) {
    return FutureBuilder(
        future: getButtonData(widget.wsId, widget.item['id']),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) 
          return CircularProgressIndicator();
          return Column(
            children: buttonsList(snapshot.data.toList(), context),
          );
        });
  }
}

dynamic getButtonData(String wsId, String containerId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  buttons = await db.fetchButtonData(wsId,containerId, sharedPreferences.get("TemplateId"));
  return buttons;
}


_saveDataHierarchy() async {
  var db = new DatabaseHelper();
  var listHierarchy=json.decode(json.encode(listOfHierarchy[0]));
  listHierarchy.forEach((key,value) async {
    if((key.split('.').length)==1) {
      print("store model.map "+key);
      var pkColumnNameList = await db.checkIfPkExist(key);
        var pkColName = pkColumnNameList[0]['name'];
        // if(value.containsKey(pkColName) == true) {
        //   return 1;
        // }else {
        //   return 0;
        // }
        if(value[0].containsKey(pkColName) == true) {
          //TODO: edit case
        }
        else{
          var uuid = new Uuid();
          interimId = uuid.v4();
          mapOfPrimaryKeys.putIfAbsent(key,()=>interimId);
          await db.populateTableWithCustomColumn(key.toUpperCase(), value[0] as Map<String,dynamic>,pkColName, interimId,false);
        }
      }else {
      var keysArray =  key.split('.');
      for(int i=0;i<keysArray.length;i++) {
        var parentTableName =  keysArray[(keysArray.length - 2)];
        var childTableName =  keysArray[(keysArray.length - 1)];
        await  db.checkIfTableExist(parentTableName.toUpperCase(), false).then((isParentTableExist) async {
          if(isParentTableExist > 0) {
            await db.isColumnExistInTable(parentTableName.toUpperCase(), childTableName).then((isColumnExist)async{
              if (isColumnExist > 0) {
                print("store model.json " + key);
                List<String> keyHierarchy= key.toString().split('.');
                keyHierarchy.removeLast();
                var parentPrimaryKey = mapOfPrimaryKeys[keyHierarchy.join('.')];
                await db.updateTableColumn(parentTableName.toUpperCase(), json.encode(value[0]), childTableName, false, interimId: parentPrimaryKey);
              }else {
                print("store model.modelmap "+ key);
                await db.isColumnExistInTable(childTableName.toUpperCase(), childTableName).then((isColumnExist) async {
                  var pkColumnNameList = await db.checkIfPkExist(childTableName);
                  var pkColName = pkColumnNameList[0]['name'];
                  var uuid = new Uuid();
                  interimId = uuid.v4();
                  mapOfPrimaryKeys.putIfAbsent(key, () => interimId);
                  await db.populateTableWithCustomColumn(childTableName.toUpperCase(), value[0] as Map<String, dynamic>, pkColName, interimId, false);
                });
              }
            });
          }
        });
      }
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    DateTime timeStamp = DateTime.now();
    String currentTime = timeStamp.toIso8601String();
    transQData.forEach((key,val) async {
      switch (key) {
        case "transQueueId": {
          var transUuid = new Uuid();
          transQData[key] = transUuid.v4();
        }
        break;
        case "requestId": {
          transQData[key] = mapOfPrimaryKeys['Item'];
        }
        break;
        case "projectId": {
          transQData[key] = sharedPreferences.get("projectId");
        }
        break;
        case "userId": {
          transQData[key] = sharedPreferences.get("userId");
        }
        break;
        case "status": {
          transQData[key] = 1;
        }
        break;
        case "syncStatus": {
          transQData[key] = 'NOT SYNC';
        }
        break;
        case "wsId": {
          transQData[key] = sharedPreferences.get("wsId");
        }
        break;
        case "createdData": {
          transQData[key] = currentTime;
        }
        break;
        case "updateData": {
          transQData[key] = currentTime;
        }
        break;
      }
    });
    db.populateTableWithMapping("TRANS_QUEUE", transQData, true);
  });
}


List<Widget> buttonsList(dynamic list, context) {
  List<Widget> buttonList = [];
  for(int i=0;i<list.length;i++) {
    buttonList.add(
      RaisedButton(
        onPressed: () {
          var operationOnButtonClick = list[i]['operation'];
          switch (operationOnButtonClick) {
            case "SAVE": {_saveDataHierarchy();}
            break;
            case "CLOSE": {Navigator.push(context,MaterialPageRoute(builder: (context) =>Menus(),fullscreenDialog: true));}
            break;
          }
        },
        child: Text(list[i]['operation']),
      )
    );
  }
  return buttonList;
}

/*
FutureBuilder<String>(
            future: db.getTextFieldLabel(widget.item['label']),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) return new Text(addAsterisk(widget.item['label']), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
              return new Text(addAsterisk(snapshot.data.toString()), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
            }),
*/


/*
ListView.builder(
        itemCount: widget.buttons.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index) {
          return RaisedButton(
            onPressed: () {
              var operationOnButtonClick = buttons[index]['operation'];
              switch (operationOnButtonClick) {
                case "SAVE": {_saveDataHierarchy();}
                break;
                case "CLOSE": {Navigator.push(context,MaterialPageRoute(builder: (context) =>Menus(),fullscreenDialog: true));}
                break;
              }
            },
            child: Text(widget.buttons[index]['label']),
          );
        },
      )
*/