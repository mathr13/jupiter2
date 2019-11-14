import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/Screens/Views/home.dart' as prefix0;
import 'package:jupiter/forms/customButtons.dart';
import 'package:jupiter/forms/customHiddenField.dart';
import 'package:meta/meta.dart';
import 'switch.dart';
import 'radio.dart';
import 'textfield.dart';
import 'checkBox.dart';
import 'package:jupiter/forms/customDropdown.dart';
import 'package:jupiter/forms/customDatepicker.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'headers.dart';

var id;
bool rowTrue=false;
var db = new DatabaseHelper();
int cont = 1;

Map<String, dynamic> responseDetails = {};
Map<String, dynamic> jsonData = {};

class CoreForm extends StatefulWidget {
  CoreForm({@required this.form, this.jsonForm});

  final String form;
  String jsonForm;
  int s=0;

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
  dynamic formSections;

  List<Widget> jsonToForm() {
    data = json.decode(widget.jsonForm);
    List<Widget> listWidget = new List<Widget>();
    formSections = data['data']['FORM'][0]['sections'][0]['sections'];
    for (int i = 0; i < formSections.length; i++) {
//      listWidget.add(SectionHeader(text: "Header",));
     int noOfColumns=formSections[i]['colIndex'];
      int noOfRows=formSections[i]['rowIndex'];
      for (var count = 0; count < formSections[i]['definition'].length; count++) {
        print("formDefinationComponent = $count");
        Map item = formSections[i]['definition'][count];
        switch (item['type']) {
          case "text":
            {
              if (item['subType'] != 'date') {
                listWidget.add(CustomText(
                    item: item, count: count, onChanged: (dynamic response) {
                  responseDetails = response;
                },
                    formItems: formSections[i]['definition'],widthPart: 4,
                ));
              }
            }
            break;
          case "Password":
            {
              if (item['subType'] != 'date') {
                listWidget.add(CustomText(
                    item: item, count: count, onChanged: (dynamic response) {
                  responseDetails = response;
                },
                    formItems: formSections[i]['definition']
                ));
              }
            }
            break;
          case "hidden":
            {
              listWidget.add(CustomHidden(
                  item: item,
                  count: count,
                  onChanged: (dynamic response) {
                    responseDetails = response;
                  },
                  formItems: formSections[i]['definition'],
                  defaultValue: item['defaultValue']
              ));
            }
            break;
          case "radio":
            {
              listWidget.add(CustomRadio(
                  item: item, count: count, onChanged: (dynamic response) {
                responseDetails = response;
              },
                  formItems: formSections[i]['definition']
              ));
            }
            break;
          case "Switch":
            {
              listWidget.add(CustomSwitch(
                  item: item, count: count, onChanged: (dynamic response) {
                responseDetails = response;
              },
                  formItems: formSections[i]['definition']
              ));
            }
            break;
          case "checkbox":
            {
              listWidget.add(CustomCheckBox(
                  item: item, count: count, onChanged: (dynamic response) {
                responseDetails = response;
              },
                  formItems: formSections[i]['definition']
              ));
            }
            break;
          case "select":
            {
              listWidget.add(DropdownButtonHint(
                  item: item,
                  count: count,
                  onChanged: (dynamic response) {
                    responseDetails = response;
                  },
                  formItems: formSections[i]['definition'],
              ));
              widget.s++;
            }
            break;
          case "date":
            {
              listWidget.add(CustomDatePicker(
                  item: item, count: count, onChanged: (dynamic response) {
                responseDetails = response;
              },
                  formItems: formSections[i]['definition']
              ));
            }
            break;
          case "navigationContainer":
            {
              listWidget.add(CustomButton(
                item: item,
                wsId: wsId,
              ));
            }
            break;
        }
      }
    }
    return listWidget;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: rowTrue==true ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: jsonToForm(),
      ): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: jsonToForm(),
      ),
    );
  }
}
