import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/forms/CustomButtons.dart';
import 'package:jupiter/forms/CustomHiddenField.dart';
import 'package:meta/meta.dart';
import 'switch.dart';
import 'radio.dart';
import 'textfield.dart';
import 'checkbox.dart';
import 'jsondata.dart';
import 'package:jupiter/forms/CustomDropdown.dart';
import 'package:jupiter/forms/Custom_Datepicker.dart';

var id;
var db = new DatabaseHelper();
int cont = 1;

Map<String, dynamic> responseDetails = {};
Map<String, dynamic> jsonData = {};

class CoreForm extends StatefulWidget {
  CoreForm({@required this.form, this.jsonForm});

  final String form;
  String jsonForm;

  @override
  _CoreFormState createState() => new _CoreFormState();
}

class _CoreFormState extends State<CoreForm> {
  @override
  void initState() {
    super.initState();
    // _saveData();
  }

  // _saveData() async{
  //   await db.dbRender;
  //   var info = json.decode(json.encode(inputData));
  //   Data data = new Data.fromJson(info);
  //   var navigate=json.decode(nagivationData);
  //   for(int i=0;i<navigate[0]['NavigationMapping'].length;i++)
  //     {
  //   await db.insert("Navigate",navigate[0]['NavigationMapping'][i]as Map);
  //     }
  //   for(int i=0;i<data.lov.length;i++)
  //   {
  //     await db.insert("LOV",data.lov[i].pro);
  //   }
  // }
  dynamic data;
  dynamic formItems;

  List<Widget> jsonToForm() {
    data = json.decode(widget.jsonForm);
    List<Widget> listWidget = new List<Widget>();
      formItems = data[0]['definition'];
        for (var count = 0; count < formItems.length; count++) {
          Map item = formItems[count];
          switch (item['type']) {
            case "text": {
              if(item['subType'] != 'date') {
                listWidget.add(CustomText(
                  item: item, count: count, onChanged: (dynamic response) {responseDetails=response;},
                  formItems: formItems
                ));
              }
            }
            break;
            case "Password": {
              if(item['subType'] != 'date') {
                listWidget.add(CustomText(
                  item: item, count: count, onChanged: (dynamic response) {responseDetails=response;},
                  formItems: formItems
                ));
              }
            }
            break;
            case "hidden": {
              listWidget.add(CustomHidden(
                item: item, count: count, onChanged: (dynamic response) {responseDetails=response;},
                formItems: formItems, defaultValue: item['defaultValue']
              ));
            }
            break;
            case "radio": {
              listWidget.add(CustomRadio(
                item: item, count: count, onChanged: (dynamic response) {responseDetails = response;},
                formItems: formItems
              ));
            }
            break;
            case "Switch": {
              listWidget.add(CustomSwitch(
                item: item, count: count, onChanged: (dynamic response) {responseDetails = response;},
                formItems: formItems
              ));
            }
            break;
            case "checkbox": {
              listWidget.add(CustomCheckBox(
                item: item, count: count, onChanged: (dynamic response) {responseDetails = response;},
                formItems: formItems
              ));
            }
            break;
            case "select": {
              listWidget.add(DropdownButtonHint(
                item: item, count: count, onChanged: (dynamic response) {responseDetails = response;},
                formItems: formItems,
              ));
            }
            break;
            case "date": {
              listWidget.add(CustomDatePicker(
                item: item, count: count, onChanged: (dynamic response) {responseDetails = response;},
                formItems: formItems
              ));
            }
            break;
            case "navigationContainer": {
              listWidget.add(CustomButton(
                buttons: buttons,
                item: item,
                wsId: wsId,
              ));
            }
            break;
          }
      }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: jsonToForm(),
      ),
    );
  }
}
