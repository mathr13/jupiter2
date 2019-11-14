import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:uuid/uuid.dart';
import 'package:jupiter/hierarchyFormRendering/parentForm.dart';
class ButtonRender extends StatefulWidget {
  @override
  _ButtonRenderState createState() => _ButtonRenderState();
}
var db = DatabaseHelper();
dynamic interimId;

class _ButtonRenderState extends State<ButtonRender> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:RaisedButton(
        color: Colors.green,
        onPressed:_saveDataHierarchy ,
      )
    );
  }
}
_saveDataHierarchy() async {
  var db = new DatabaseHelper();
  var listHierarchy=json.decode(json.encode(listOfHierarchy[0]));
  print(listHierarchy);
  listHierarchy.forEach((key,value) async {
    if ((key
        .split('.')
        .length) == 1) {
      print("store model.map " + key);
      var pkColumnNameList = await db.checkIfPkExist(key);
      var pkColName = pkColumnNameList[0]['name'];
      // if(value.containsKey(pkColName) == true) {
      //   return 1;
      // }else {
      //   return 0;
      // }
      if (value[0].containsKey(pkColName) == true) {
        //TODO: edit case
      }
      else {
        var uuid = new Uuid();
        interimId = uuid.v4();
        mapOfPrimaryKeys.putIfAbsent(key, () => interimId);
        await db.populateTableWithCustomColumn(
            key.toUpperCase(), value[0] as Map<String, dynamic>, pkColName,
            interimId, false);
      }
    } else {
      var keysArray = key.split('.');
      for (int i = 0; i < keysArray.length; i++) {
        var parentTableName = keysArray[(keysArray.length - 2)];
        var childTableName = keysArray[(keysArray.length - 1)];
        await db.checkIfTableExist(parentTableName.toUpperCase(), false).then((
            isParentTableExist) async {
          if (isParentTableExist > 0) {
            await db.isColumnExistInTable(
                parentTableName.toUpperCase(), childTableName).then((
                isColumnExist) async {
              if (isColumnExist > 0) {
                print("store model.json " + key);
                List<String> keyHierarchy = key.toString().split('.');
                keyHierarchy.removeLast();
                var parentPrimaryKey = mapOfPrimaryKeys[keyHierarchy.join('.')];
                await db.updateTableColumn(
                    parentTableName.toUpperCase(), json.encode(value[0]),
                    childTableName, false, interimId: parentPrimaryKey);
              } else {
                print("store model.modelmap " + key);
                await db.isColumnExistInTable(
                    childTableName.toUpperCase(), childTableName).then((
                    isColumnExist) async {
                  var pkColumnNameList = await db.checkIfPkExist(
                      childTableName);
                  var pkColName = pkColumnNameList[0]['name'];
                  var uuid = new Uuid();
                  interimId = uuid.v4();
                  mapOfPrimaryKeys.putIfAbsent(key, () => interimId);
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