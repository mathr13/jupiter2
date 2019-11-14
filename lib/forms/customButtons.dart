import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'formRendering.dart';
import 'package:uuid/uuid.dart';
import 'package:jupiter/List/listingView.dart';
//import 'package:jupiter/Screens/Views/troy.dart';

var db = DatabaseHelper();
dynamic interimId;
Map<String, dynamic> transQData = {'transQueueId': '', 'requestId': '', 'requestData': '', 'lookUpData': '','projectId': '','userId': '', 'status': '', 'syncStatus': '', 'conflicts': '', 'responseData': '', 'wsId': '', 'createdData': '', 'updateData': ''};

class CustomButton extends StatefulWidget {
  final String wsId;
  final Map item;
  // final List<dynamic> buttons;

  CustomButton({@required this.wsId,this.item});

  @override _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override Widget build(BuildContext context) {
    return FutureBuilder(
        future: getButtonData(widget.wsId, widget.item['id']),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) 
          return CircularProgressIndicator();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttonsList(snapshot.data.toList(), context),
          );
        });
  }
}

dynamic getButtonData(String wsId, String containerId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return await db.fetchButtonData(wsId,containerId, sharedPreferences.get("TemplateId"));
}

 saveDataHierarchy(context) async {
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
          primaryKey=interimId;
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
    print("In the middle of loop");

//    await Future.delayed(Duration(seconds: 3));
//    Navigator.push(context, MaterialPageRoute(builder: (context) => ListingView()));

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
  await Future.delayed(Duration(seconds: 3));
  Navigator.push(context, MaterialPageRoute(builder: (context) => ListingView()));
}
//saveDraft(context) async {
//  var db = new DatabaseHelper();
//  var listHierarchy=json.decode(json.encode(listOfHierarchy[0]));
//  listHierarchy.forEach((key,value) async {
//    if ((key
//        .split('.')
//        .length) == 1) {
//
//        await db.updateTableWithMapping(
//            key.toUpperCase(), value[0] as Map<String, dynamic>,false, 'id',
//            primaryKey);
//    } else {
//      var keysArray = key.split('.');
//      for (int i = 0; i < keysArray.length; i++) {
//        var parentTableName = keysArray[(keysArray.length - 2)];
//        var childTableName = keysArray[(keysArray.length - 1)];
//        await db.checkIfTableExist(parentTableName.toUpperCase(), false).then((
//            isParentTableExist) async {
//          if (isParentTableExist > 0) {
//            await db.isColumnExistInTable(
//                parentTableName.toUpperCase(), childTableName).then((
//                isColumnExist) async {
//              if (isColumnExist > 0) {
//                print("store model.json " + key);
//                List<String> keyHierarchy = key.toString().split('.');
//                keyHierarchy.removeLast();
//                var parentPrimaryKey = mapOfPrimaryKeys[keyHierarchy.join('.')];
//                await db.updateTableColumn(
//                    parentTableName.toUpperCase(), json.encode(value[0]),
//                    childTableName, false, interimId: parentPrimaryKey);
//              } else {
//                print("store model.modelmap " + key);
//                await db.isColumnExistInTable(
//                    childTableName.toUpperCase(), childTableName).then((
//                    isColumnExist) async {
//                  var pkColumnNameList = await db.checkIfPkExist(
//                      childTableName);
//                  var pkColName = pkColumnNameList[0]['name'];
//                  var uuid = new Uuid();
//                  interimId = uuid.v4();
//                  mapOfPrimaryKeys.putIfAbsent(key, () => interimId);
//                  await db.updateTableWithMapping(childTableName
//                      .toUpperCase(), value[0] as Map<String, dynamic>,
//                      false, "id", primaryKey);
//                });
//              }
//            });
//          }
//        });
//      }
//    }
//    print("In the middle of loop");
//
////    await Future.delayed(Duration(seconds: 3));
////    Navigator.push(context, MaterialPageRoute(builder: (context) => ListingView()));
//  });
//      }


List<Widget> buttonsList(dynamic list, context) {
  List<Widget> buttonList = [];
  for(int i=0;i<list.length;i++) {
    buttonList.add(
      RaisedButton(
        onPressed: () {
          var operationOnButtonClick = list[i]['operation'];
          switch (operationOnButtonClick) {
            case "SAVE": {
              saveDataHierarchy(context);
              _operationSave(list[i], context);
            }
            break;
            case "CLOSE": {
              Navigator.push(context,MaterialPageRoute(builder: (context) =>Menus(),fullscreenDialog: true));}
            break;
            case "LIST_SELECTION":{

              break;
            }
            case "SAVE_GLOBAL":{

             _saveCatIdToDatabase(list[i],context);




            break;
            }
          }
        },
        child: Text(list[i]['label']),
      )
    );
  }
  return buttonList;
}
var subCatIdValue;
_saveCatIdToDatabase(list,context)async{
  var db = DatabaseHelper();
   subCatIdValue= json.decode(json.encode(listOfHierarchy[0][""][0]['subCatId']));
  Map<String,dynamic> subCat = {
    'key': 'subCatID',
    'value': "$subCatIdValue",
    'projectId': 11103
  };
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("TemplateId", list['redirectFormId']);
  _getTemplateId() async {
    var db = new DatabaseHelper();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id= sharedPreferences.get('TemplateId');
    res=  await db.fetchTemplateID(id);
    //TODO: REVERT RETURN
    return res[0]['section'].toString();
  }
  await db.populateTableWithMapping("GLOBALVARIABLE", subCat, true);
  await _getTemplateId().then((list){
    Navigator.push(context,MaterialPageRoute(builder: (context) =>ListingView(listData: list,value: subCatIdValue,)));

  });

//  await db.getItemListingResults("ITEMTYPE", null, null, null,subCatIdValue ).then((list){
//    Navigator.push(context,MaterialPageRoute(builder: (context) =>App()));
//
//      });


//  var listingDataResults = db.getItemListingResults("ITEMTYPE", null, null, filters, value)

}
_operationSave(list,context)async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("TemplateId", list['redirectFormId']);
  _getTemplateId() async {
    var db = new DatabaseHelper();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id= sharedPreferences.get('TemplateId');
    res=  await db.fetchTemplateID(id);
    //TODO: REVERT RETURN
    return res[0]['section'].toString();
  }
  await _getTemplateId().then((list){
    Navigator.push(context,MaterialPageRoute(builder: (context) =>ListingView(listData: list,value: subCatIdValue,label: res[0]['formLabel'].toString(),)));

  });
}