import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/forms/checkBox.dart';
import 'package:jupiter/forms/customDatepicker.dart';
import 'package:jupiter/forms/customDropdown.dart';
import 'package:jupiter/forms/customHiddenField.dart';
import 'package:jupiter/forms/radio.dart';
import 'package:jupiter/forms/switch.dart';
import 'package:jupiter/forms/textfield.dart';
import 'package:image_picker/image_picker.dart';


Map<String, dynamic> responseDetails = {};
var height,width;
List<dynamic> heightsList = [0,0,0,0];
GlobalKey one = GlobalKey();
GlobalKey two = GlobalKey();
GlobalKey three = GlobalKey();
GlobalKey four = GlobalKey();
GlobalKey five = GlobalKey();
List<GlobalKey> keys = [one,two,three,four];
var db = DatabaseHelper();



Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}
Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}
String base64String(Uint8List data) {
  return base64Encode(data);
}

class Gridxo extends StatefulWidget {
  @override _MenusState createState() => _MenusState();
}

class _MenusState extends State<Gridxo> {
  Future<File> imageFile;
    Image image;

  @override void initState() {
    super.initState();
  }


  @override Widget build(BuildContext context) {
    // pickImageFromGallery();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    List<Widget> lol = [Text("a"),Text("b"),Text("c")];
    String defiData = '{"data":{"projectId":11103,"FORM":[{"rows":1,"cols":1,"formId":"fdf07735-6c31-4f49-a31f-ff86bb5e0259","formLabel":"ITEM_LISTING1","sections":{"rowIndex":1,"colIndex":1,"sections":[{"rowIndex":1,"colIndex":1,"sectionId":"cUtwCr6669NEWR2m","definition":[{"id":"t5","label":"11a5851d-f2c1-4ba5-9239-0fe672ccbe69","type":"select","subType":"select","regex":"","constraint":"MANDATORY","key":"","lov":"97add0d9-1a69-4aca-87d0-3b5e43765c4f","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"97add0d9-1a69-4aca-87d0-3b5e43765c4f"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t5","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2},{"rowIndex":1,"colIndex":2,"sectionId":"02eGI8eFVOoZyiWc","definition":[{"id":"t2","label":"a3e80999-e85a-4eab-9076-facbff5a227d","type":"text","subType":"text","regex":"","constraint":"MANDATORY","key":"S","lov":"","delim":"","mapAttr":"","dataSource":[],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t2","nodeHierarchy":"Item.specAttr","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"OPTIONAL","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":1,"sectionId":"NEMfilc5QNcp2S4J","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"costCode","label":"PURCHASE_COST_CENTER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"costCode","nodeHierarchy":"Item","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":2,"sectionId":"xsPc6mnYdVh0f2qx","definition":[{"id":"t5","label":"11a5851d-f2c1-4ba5-9239-0fe672ccbe69","type":"select","subType":"select","regex":"","constraint":"MANDATORY","key":"","lov":"97add0d9-1a69-4aca-87d0-3b5e43765c4f","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"97add0d9-1a69-4aca-87d0-3b5e43765c4f"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t5","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2}],"row":2,"cols":2}}]},"status":{"messageList":[],"messageCode":1200}}';
    final defiDataResp = json.decode(defiData);
    lol = childList(defiDataResp,context);
    return Scaffold(
      appBar: AppBar(title: Text("FORM")),
      body: FutureBuilder(
        future: getComponentsData(defiDataResp, context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            // for(int i=0;i<keys.length;i++) {
            //   getSizes(keys[i], i);
            // }
            return ListView(children: lol);
          }
          for(int i=0;i<keys.length;i++) {
            getSizes(keys[i], i);
            // print(heightsList);
          }
          // fillFormData(defiDataResp);
          return ListView(children: lol);
        }
      ),
    );
  }
}

void fillFormData(dynamic data) async {
  await db.populateTableWithMapping("FORMS", data['data']['FORM'][0], false);
  for(int i=0;i<data['data']['FORM'][0]['sections']['sections'].length;i++) {
    await db.populateTableWithMapping("SECTIONS", data['data']['FORM'][0]['sections']['sections'][i], false);
  }
}

Future<dynamic> getComponentsData(dynamic data, context) async {
  await Future.delayed(Duration(seconds: 1));
  return childList(data, context);
}

List<Widget> childList(dynamic data, context) {
  print(data['data']['FORM'][0]['sections']['sections'][0]['colIndex']);
  List<Widget> listOfChildren = [];
  int count = 0;
  for(int i=0;i<data['data']['FORM'][0]['sections']['sections'].length;i++) {
    if(count==i) {
      if(data['data']['FORM'][0]['sections']['sections'][count]['colSpan']==2) {
        listOfChildren.add(
          Container(
            // key: keys[i],
            color: Colors.red[(count+1)*100],
            // height: (height)/(data['data']['FORM'][0]['sections']['row']+1),
            height: heightsList[i].toDouble(),
            width: width,
            child: GridView.count(
              // physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: childWidget(data, count),
                )
              ],
            ),
          )
        );
        count++;
      }else {
        List<Widget> test = [];
        test.addAll(childWidget(data, count+1));
        listOfChildren.add(
          Container(
            color: Colors.blue[(count+1)*100],
            height: (height)/(data['data']['FORM'][0]['sections']['row']+1),
            width: width,
            child: GridView.count(
              // physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.45,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: childWidget(data, count),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: childWidget(data, count+1),
                )
              ],
            ),
          )
        );
        count += 2;
      }
    }
  }
  return listOfChildren;
}

void getSizes(GlobalKey key, int index) async {
  if(key.currentContext!=null) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    // renderBox.markNeedsLayoutForSizedByParentChange();
    // renderBox.performResize();
    heightsList[index] = renderBox.size.height;
    // print(renderBox.size.height);
  }
}


List<Widget> childWidget(dynamic data, int index) {
  List<Widget> listWidget = [];
  for(int i=0;i<data['data']['FORM'][0]['sections']['sections'][index]['definition'].length;i++) {
    Map item = data['data']['FORM'][0]['sections']['sections'][index]['definition'][i];
    switch (item['type']) {
      case "text": {
        if(item['subType'] != 'date') {
          listWidget.add(Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: CustomText(
            item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
            formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
          ),
            ));
        }
      }
      break;
      case "Password": {
        if(item['subType'] != 'date') {
          listWidget.add(Padding(child: CustomText(
            item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
            formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
          ),padding: EdgeInsets.fromLTRB(10, 5, 10, 0)));
        }
      }
      break;
      case "hidden": {
        listWidget.add(Padding(
          child: CustomHidden(
          item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition'], defaultValue: item['defaultValue']
        ),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),)
        );
      }
      break;
      case "radio": {
        listWidget.add(Padding(child: Container(
          key: keys[i],
          child: CustomRadio(
          item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
        ),
        ),padding: EdgeInsets.fromLTRB(10, 5, 10, 0),));
      }
      break;
      case "Switch": {
        listWidget.add(Padding(child: CustomSwitch(
          item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
        ),padding: EdgeInsets.fromLTRB(10, 5, 10, 0),));
      }
      break;
      case "checkbox": {
        listWidget.add(Padding(
          child: Container(key: keys[index], child: CustomCheckBox(
          item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
        )),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        ));
      }
      break;
      case "select": {
        listWidget.add(Padding(
          child: Container(key: keys[index], child: DropdownButtonHint(
          item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition'],
        )),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        ));
      }
      break;
      case "date": {
        listWidget.add(Padding(
          child: CustomDatePicker(
          item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
        ),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        ));
      }
      break;
      case "navigationContainer": {
        // listWidget.add(Padding(
        //   child: CustomButton(
        //   item: item,
        //   wsId: wsId,
        // ),
        // padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        // ));
      }
      break;
    }
  }
  return listWidget;
}


//----------------------------------------------------------------------------------------------------------------



Widget childFunction(dynamic data) {
  Widget renders;
  for(int i=0;i<data['data']['FORM'][0]['sections']['sections'].length;i++) {
    if(data['data']['FORM'][0]['sections']['sections'][i]['cols']==0) {
      // print(data['data']['FORM'][0]['sections']['sections'][i]['sectionId']);
      renders = GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 0.45),
          itemCount: data['data']['FORM'][0]['sections']['row']*data['data']['FORM'][0]['sections']['cols'],
          itemBuilder: (BuildContext context, int index) {
            return Container(
              // color: Colors.orange[(index+1)*100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: childWidget(data, index),
              )
            );
          },
        );
    }else {
      renders = 
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: data['data']['FORM'][0]['sections']['cols'],childAspectRatio: 0.45),
          itemCount: data['data']['FORM'][0]['sections']['row']*data['data']['FORM'][0]['sections']['cols'],
          itemBuilder: (BuildContext context, int index) {
            return Container(
              // color: Colors.orange[(index+1)*100],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: childWidget(data, index),
                ),
              ),
            );
          },
      );
    }
  }
  return renders;
}