import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/forms/checkBox.dart';
import 'package:jupiter/forms/customDatepicker.dart';
import 'package:jupiter/forms/customDropdown.dart';
import 'package:jupiter/forms/customHiddenField.dart';
import 'package:jupiter/forms/radio.dart';
import 'package:jupiter/forms/switch.dart';
import 'package:jupiter/forms/textfield.dart';
import 'package:jupiter/forms/customButtons.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:uuid/uuid.dart';


Map<String, dynamic> responseDetails = {};
var height,width;
List<List<dynamic>> theHeightsList = [];
List<dynamic> heightBuff = [];
List<int> sectionsList = [];
List<String> defaultKeyNames = [];
List<GlobalKey> myKeys = [];
List<List<GlobalKey>> theKeys = [];
List<GlobalKey> keyBuff = [];
int checker = 0;
dynamic defiDataResp;

var db = DatabaseHelper();
var uuid = new Uuid();

class Gridxo extends StatefulWidget {
  @override _MenusState createState() => _MenusState();
}

class _MenusState extends State<Gridxo> {
  @override void initState() {
    super.initState();
    myKeys.clear();
    defaultKeyNames.clear();
    theKeys.clear();
    theHeightsList.clear();
    String defiData = '{"data":{"projectId":11103,"FORM":[{"rows":1,"cols":1,"formId":"fdf07735-6c31-4f49-a31f-ff86bb5e0259","formLabel":"ITEM_LISTING1","sections":{"rowIndex":1,"colIndex":1,"sections":[{"rowIndex":1,"colIndex":1,"sectionId":"cUtwCr6669NEWR2m","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"t5","label":"11a5851d-f2c1-4ba5-9239-0fe672ccbe69","type":"select","subType":"select","regex":"","constraint":"MANDATORY","key":"","lov":"97add0d9-1a69-4aca-87d0-3b5e43765c4f","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"97add0d9-1a69-4aca-87d0-3b5e43765c4f"}],"secondaryEntityName":null,"secondaryValueMember":null,"secondaryDisplayMember":null,"nodeHierarchy":null}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t5","nodeHierarchy":"Item.attr","defaultValue":""},{"id":"locId","label":"LOCATION","type":"select","subType":"select","constraint":"MANDATORY","dataSource":[{"entityName":"location","valueMember":"locId","displayMember":"name","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"parentLocId","value":"##typeId"}],"toLook":"parentLocId"}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"locId","nodeHierarchy":"Item","defaultValue":""},{"id":"t9","label":"ce9322e5-7e16-4e6e-89b9-8e3447b062e0","type":"checkbox","subType":"checkbox","regex":"","constraint":"OPTIONAL","key":"","lov":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b"}],"secondaryEntityName":null,"secondaryValueMember":null,"secondaryDisplayMember":null,"nodeHierarchy":null}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t9","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2},{"rowIndex":1,"colIndex":2,"sectionId":"02eGI8eFVOoZyiWc","definition":[{"id":"t2","label":"a3e80999-e85a-4eab-9076-facbff5a227d","type":"text","subType":"text","regex":"","constraint":"MANDATORY","key":"S","lov":"","delim":"","mapAttr":"","dataSource":[],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t2","nodeHierarchy":"Item.specAttr","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"OPTIONAL","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":1,"sectionId":"NEMfilc5QNcp2S4J","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"costCode","label":"PURCHASE_COST_CENTER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"costCode","nodeHierarchy":"Item","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":2,"sectionId":"xsPc6mnYdVh0f2qx","definition":[{"id":"container1","label":"navigationContainer1","type":"navigationContainer","subType":"navigationContainer","constraint":"MANDATORY","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"container1","nodeHierarchy":"Item","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"OPTIONAL","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2}],"row":2,"cols":2}}]},"status":{"messageList":[],"messageCode":1200}}';
    defiDataResp = json.decode(defiData);
    String keyName;
    int sections = 0;
    for(int i=0;i<defiDataResp['data']['FORM'][0]['sections']['sections'].length;i++) {
      for(int j=0;j<defiDataResp['data']['FORM'][0]['sections']['sections'][i]['definition'].length;j++) {
        keyName = uuid.v4();
        sections++;
        defaultKeyNames.add(keyName);
      }
      sectionsList.add(sections);
    }
    for (String name in defaultKeyNames) {
      final GlobalKey name = GlobalKey();
      myKeys.add(name);
    }
    int keyIndex = 0;
    int sectionIndex = 0;
    while(sectionIndex<sectionsList.length) {
      while(keyIndex<sectionsList[sectionIndex]) {
        keyBuff.add(myKeys[keyIndex]);
        heightBuff.add(0);
        keyIndex++;
      }
      theKeys.add(keyBuff.toList());
      theHeightsList.add(heightBuff.toList());
      keyBuff.clear();
      heightBuff.clear();
      sectionIndex++;
    }
  }
  
  @override Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: getComponentsData(defiDataResp, context, theKeys),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) return ListView(children: childList(defiDataResp,context,theKeys));
        for(int i=0;i<theKeys.length;i++) {
          for(int j=0;j<theKeys[i].length;j++) {
            getSizes(theKeys[i][j], i, j);
          }
        }
        return ListView(children: childList(defiDataResp,context,theKeys));
      }
    );
  }
}

Future<dynamic> getComponentsData(dynamic data, context, List<List<GlobalKey>> keys) async {
  await Future.delayed(Duration(seconds: 1));
  return childList(data, context, keys);
}

List<Widget> childList(dynamic data, context, List<List<GlobalKey>> keys) {
  List<Widget> listOfChildren = [];
  int count = 0;
  for(int i=0;i<data['data']['FORM'][0]['sections']['sections'].length;i++) {
    if(count==i) {
      dynamic sum = 0;
      for(int j=0;j<theHeightsList[i].length;j++) {
        sum += theHeightsList[i][j];
      }
      if(data['data']['FORM'][0]['sections']['sections'][count]['colSpan']==2) {
        listOfChildren.add(
          Container(
            height: sum.toDouble(),
            width: width,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: (width-20)/sum,
              crossAxisCount: 1,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: childWidget(data, count, keys),
                )
              ],
            ),
          )
        );
        count++;
      }else {
        dynamic sum2 = 0;
        for(int j=0;j<theHeightsList[count+1].length;j++) {
          sum2 += theHeightsList[count+1][j];
        }
        if(sum2>sum) sum = sum2;
        List<Widget> test = [];
        test.addAll(childWidget(data, count+1, keys));
        listOfChildren.add(
          Container(
            height: sum.toDouble(),
            width: width,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.45,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: childWidget(data, count, keys),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: childWidget(data, count+1, keys),
                )
              ],
            ),
          )
        );
        count += 2;
        sum2 = 0;
      }
      sum = 0;
    }
  }
  for(int i=0;i<theHeightsList.length;i++) {
    for(int j=0;j<theHeightsList[i].length;j++) {
      theHeightsList[i][j] = 0;
    }
  }
  checker++;
  return listOfChildren;
}

void getSizes(GlobalKey key, int sectionIndex, int widgetIndex) async {
  if(key.currentContext!=null) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    theHeightsList[sectionIndex][widgetIndex] += renderBox.size.height;
    // print(theHeightsList);
    // print("----------------------------------------------------------------------------------------");
  }
}

List<Widget> childWidget(dynamic data, int index, List<List<GlobalKey>> keys) {
  List<Widget> listWidget = [];
  for(int i=0;i<data['data']['FORM'][0]['sections']['sections'][index]['definition'].length;i++) {
    Map item = data['data']['FORM'][0]['sections']['sections'][index]['definition'][i];
    switch (item['type']) {
      case "text": {
        if(item['subType'] != 'date') {
          listWidget.add(Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              key: keys[index][i],
              child: CustomText(
            item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
            formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
          ),
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
          ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0)));
        }
      }
      break;
      case "hidden": {
        listWidget.add(Padding(
          child: CustomHidden(
          item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition'], defaultValue: item['defaultValue']
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
        );
      }
      break;
      case "radio": {
        listWidget.add(Padding(child: Container(
          key: keys[index][i],
          child: CustomRadio(
          item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
        ),
        ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0),));
      }
      break;
      case "Switch": {
        listWidget.add(Padding(child: CustomSwitch(
          item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
        ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0),));
      }
      break;
      case "checkbox": {
        listWidget.add(Padding(
          child: Container(
            key: keys[index][i],
            child: CustomCheckBox(
          item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
        )),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        ));
      }
      break;
      case "select": {
        listWidget.add(
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child:Align(
              child: Container(
                key: keys[index][i],
                width: width,
                child: DropdownButtonHint(
                  item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
                  formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition'],
                )
              ),
              alignment: Alignment.topLeft,
            )
          )
        );
      }
      break;
      case "date": {
        listWidget.add(Padding(
          child: CustomDatePicker(
          item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
          formItems: data['data']['FORM'][0]['sections']['sections'][index]['definition']
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        ));
      }
      break;
      case "navigationContainer": {
         listWidget.add(Padding(
           child: Container(
             key: keys[index][i],
             child: CustomButton(
               item: item,
               wsId: wsId,
             ),
           ),
         padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
         ));
      }
      break;
    }
  }
  return listWidget;
}