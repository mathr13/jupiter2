import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:uuid/uuid.dart';

var db = DatabaseHelper();
dynamic interimId;

class CustomButton extends StatefulWidget {
  final String wsId;
  final Map item;
  final List<dynamic> buttons;

  CustomButton({@required this.buttons,this.wsId,this.item});

  @override _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override Widget build(BuildContext context) {
    getButtonData(widget.wsId, widget.item['id']);
    return Container(
      height: 50*(widget.buttons.length).toDouble(),
      child: ListView.builder(
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
    );
  }
}

void getButtonData(String wsId, String containerId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  buttons = await db.fetchButtonData(wsId,containerId, sharedPreferences.get("TemplateId"));
}


_saveDataHierarchy()async{
  var db = new DatabaseHelper();
  print(listOfHierarchy);
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
          mapOfPrimaryKeys.putIfAbsent(key,()=>interimId );
          print(mapOfPrimaryKeys);
          await db.populateTableWithCustomColumn(key.toUpperCase(), value[0] as Map<String,dynamic>,pkColName, interimId,false);
        }
      } else{
      var keysArray =  key.split('.');
      for(int i=0;i<keysArray.length;i++) {
         var parentTableName =  keysArray[(keysArray.length - 2)];
         var childTableName =  keysArray[(keysArray.length - 1)];
       await  db.checkIfTableExist(parentTableName.toUpperCase(), false).then((isParentTableExist)async{
           if(isParentTableExist > 0) {
             //print(value as Map<String,dynamic>);
              await db.isColumnExistInTable(parentTableName.toUpperCase(), childTableName).then((isColumnExist)async{
                if (isColumnExist > 0) {
                  print("store model.json " + key);
                  List<String> keyHierarchy= key.toString().split('.');
                     keyHierarchy.removeLast();
                     var parentPrimaryKey = mapOfPrimaryKeys[keyHierarchy.join('.')];
                  await db.updateTableColumn(parentTableName.toUpperCase(), json.encode(value[0]), childTableName, false, interimId: parentPrimaryKey);

                  //             await db.populateTableWithMapping(key, value as Map<String,dynamic> , false);
                }else {
                  print("store model.modelmap "+ key);
                  await db.isColumnExistInTable(
                      childTableName.toUpperCase(), childTableName).then((
                      isColumnExist) async {
                    var pkColumnNameList = await db.checkIfPkExist(
                        childTableName);
                    var pkColName = pkColumnNameList[0]['name'];

                    var uuid = new Uuid();
                    interimId = uuid.v4();
                    mapOfPrimaryKeys.putIfAbsent(key, () => interimId);
                    print(mapOfPrimaryKeys);
                    await db.populateTableWithCustomColumn(childTableName
                        .toUpperCase(), value[0] as Map<String, dynamic>,
                        pkColName, interimId, false);
                  });
                }

              });

           }
         });

        }
    }
  });

}