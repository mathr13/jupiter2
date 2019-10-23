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
  var listHierarchy=json.decode(json.encode(listOfHierarchy[0]));
  print(listHierarchy);
  listHierarchy.forEach((key,value) async {
    if((key.split('.').length)==1) {
        var pkColumnNameList = await db.checkIfPkExist(key);
        var pkColName = pkColumnNameList[0]['name'];
        // if(value.containsKey(pkColName) == true) {
        //   return 1;
        // }else {
        //   return 0;
        // }
        if(value.containsKey(pkColName) == true) {
          //TODO: edit case
        }
        else{
          var uuid = new Uuid();
          interimId = uuid.v4();
          await db.populateTableWithCustomColumn(key.toUpperCase(), value as Map<String,dynamic>,pkColName, interimId,false);
        }
      } else{
      var keysArray =  key.split('.');
      for(int i=0;i<keysArray.length;i++) {
         var parentTableName =  keysArray[(keysArray.length - 1)];
         var childTableName =  keysArray[(keysArray.length - 2)];
       await  db.checkIfTableExist(childTableName.toUpperCase(), false).then((isChildTableExist)async{
           if(isChildTableExist > 0) {
             //print(value as Map<String,dynamic>);
              await db.isColumnExistInTable(childTableName.toUpperCase(), parentTableName).then((isColumnExist)async{
                if (isColumnExist > 0) {
                  var valueJSON = (value as Map<String,dynamic>).toString();
                 // print(valueJSON);
                  await db.updateTableColumn(childTableName.toUpperCase(), json.encode(value), parentTableName, false, interimId: interimId);

                  //             await db.populateTableWithMapping(key, value as Map<String,dynamic> , false);
                }
              });

           }
         });

        }
    }
  });

}