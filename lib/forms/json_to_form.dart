
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jupiter/forms/main.dart';
import 'package:meta/meta.dart';
import 'switch.dart';
import 'radio.dart';
import 'textfield.dart';
import 'checkbox.dart';
import 'jsondata.dart';
import 'package:jupiter/forms/Databasehelper.dart';
import 'package:jupiter/forms/CustomDropdown.dart';
import 'package:jupiter/forms/Custom_Datepicker.dart';
dynamic result=json.decode(inputData);
dynamic lov = json.decode(json.encode(inputData));
var id;

Map<String,dynamic> responseDetails={};
class CoreForm extends StatefulWidget {
   CoreForm({
    @required this.form,
     this.jsonForm

  });

  final String form;
   String jsonForm;

  @override
  _CoreFormState createState() =>
      new _CoreFormState();
}

class _CoreFormState extends State<CoreForm> {
  @override
  void initState() {
    super.initState();
    _saveData();
  }

  _saveData() async{
    var db = new DatabaseHelper();
    var info = json.decode(json.encode(inputData));
    Data data = new Data.fromJson(info);
    var navigate=json.decode(nagivationData);
    for(int i=0;i<navigate[0]['NavigationMapping'].length;i++)
      {
    await db.insert("Navigate",navigate[0]['NavigationMapping'][i]as Map);
      }
    for(int i=0;i<data.lov.length;i++)
    {
      await db.insert("LOV",data.lov[i].pro);
    }
  }
  dynamic data;
   dynamic formItems;
  List<Widget> jsonToForm() {
    data = json.decode(widget.jsonForm);
    List<Widget> listWidget = new List<Widget>();
      formItems = data[0]['definition'];
      for (var count = 0; count < formItems.length; count++) {
        Map item = formItems[count];

        if (item['type'] == "text" ||
            item['type'] == "Password") {
          listWidget.add(
              CustomText(
                item: item, count: count, onChanged: (dynamic response) {
                responseDetails=response;
              }, formItems: formItems));
        }
        else if (item['type'] == "radio") {
//        var db = new DatabaseHelper();
//        db.fetchData(item['lov']).then((data) {
//          print(data);
          listWidget.add(CustomRadio(
            item: item, count: count, onChanged: (dynamic response) {
            result = response;
          }, formItems: formItems,));
//        });
        }

        else if (item['type'] == "Switch")
          listWidget.add(CustomSwitch(
            item: item, count: count, onChanged: (dynamic response) {
            result = response;
          }, formItems: formItems,));
        else if (item['type'] == "checkbox")
          listWidget.add(CustomCheckBox(
            item: item, count: count, onChanged: (dynamic response) {
            result = response;
          }, formItems: formItems,));
        else if (item['type'] == "select")
          listWidget.add(DropdownButtonHint(
            item: item, count: count, onChanged: (dynamic response) {
            result = response;
          }, formItems: formItems,)
          );
        else if (item['type'] == "date")
          listWidget.add(CustomDatePicker(
            item: item, count: count, onChanged: (dynamic response) {
            result = response;
          }, formItems: formItems,));
        else if (item['type'] == "button")
          id = item;
//          listWidget.add(Button(ext: "SUBMIT",todo:getTemplate(item),route: 'form/$title',
         // ));


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
