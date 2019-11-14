//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:jupiter/Databasehelper/databaseHelper.dart';
//import 'package:jupiter/forms/checkBox.dart';
//import 'package:jupiter/forms/customDatepicker.dart';
//import 'package:jupiter/forms/customDropdown.dart';
//import 'package:jupiter/forms/customHiddenField.dart';
//import 'package:jupiter/forms/radio.dart';
//import 'package:jupiter/forms/switch.dart';
//import 'package:jupiter/forms/textfield.dart';
//import 'package:jupiter/forms/customButtons.dart';
//import 'package:jupiter/Screens/Views/home.dart';
//import 'package:jupiter/List/listingView.dart';
//
//
//Map<String, dynamic> responseDetails = {};
//var height,width;
//// List<Map> listOfHierarchy ;
//
//
//List<List<dynamic>> theHeightsList = [[0,0,0,0],[0,0],[0,0],[0,0]];
//var db = DatabaseHelper();
//
//class Gridxo extends StatefulWidget {
// final bool isEditTrue;
// final dynamic defaultData;
// final String defiData;
//  Gridxo({this.isEditTrue,this.defaultData,this.defiData});
//  @override _MenusState createState() => _MenusState();
//}
//
//class _MenusState extends State<Gridxo> {
//  dynamic defiDataResp;
//  @override Widget build(BuildContext context) {
////    listOfHierarchy = [{}];
//    GlobalKey one = GlobalKey();
//    GlobalKey two = GlobalKey();
//    GlobalKey three = GlobalKey();
//    GlobalKey four = GlobalKey();
//    GlobalKey five = GlobalKey();
//    GlobalKey six = GlobalKey();
//    GlobalKey seven = GlobalKey();
//    GlobalKey eight = GlobalKey();
//    GlobalKey nine = GlobalKey();
//    GlobalKey ten = GlobalKey();
//    List<List<GlobalKey>> theKeys = [[one,seven,nine,ten],[two,three],[four,five],[six,eight]];
//    width = MediaQuery.of(context).size.width;
//    height = MediaQuery.of(context).size.height;
//    // String defiData = '{"data":{"projectId":11103,"FORM":[{"rows":1,"cols":1,"formId":"fdf07735-6c31-4f49-a31f-ff86bb5e0259","formLabel":"ITEM_LISTING1","sections":{"rowIndex":1,"colIndex":1,"sections":[{"rowIndex":1,"colIndex":1,"sectionId":"cUtwCr6669NEWR2m","definition":[{"id":"locId","label":"LOCATION","type":"select","subType":"select","constraint":"MANDATORY","dataSource":[{"entityName":"location","valueMember":"locId","displayMember":"name","sorting":[{"name":"asc","reverse":true}],"filters":[]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"locId","nodeHierarchy":"Item","defaultValue":""},{"id":"locId","label":"LOCATION","type":"select","subType":"select","constraint":"MANDATORY","dataSource":[{"entityName":"location","valueMember":"locId","displayMember":"name","sorting":[{"name":"asc","reverse":true}],"filters":[]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"locId","nodeHierarchy":"Item","defaultValue":""}],"rowSpan":1,"colSpan":2},{"rowIndex":1,"colIndex":2,"sectionId":"02eGI8eFVOoZyiWc","definition":[{"id":"t2","label":"a3e80999-e85a-4eab-9076-facbff5a227d","type":"text","subType":"text","regex":"","constraint":"MANDATORY","key":"S","lov":"","delim":"","mapAttr":"","dataSource":[],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t2","nodeHierarchy":"Item.specAttr","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"OPTIONAL","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":1,"sectionId":"NEMfilc5QNcp2S4J","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"costCode","label":"PURCHASE_COST_CENTER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"costCode","nodeHierarchy":"Item","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":2,"sectionId":"xsPc6mnYdVh0f2qx","definition":[{"id":"container1","label":"navigationContainer1","type":"navigationContainer","subType":"navigationContainer","constraint":"MANDATORY","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"container1","nodeHierarchy":"Item","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"OPTIONAL","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2}],"row":2,"cols":2}}]},"status":{"messageList":[],"messageCode":1200}}';
////    String defiData = '{"data":{"projectId":11103,"FORM":[{"rows":1,"cols":1,"formId":"fdf07735-6c31-4f49-a31f-ff86bb5e0259","formLabel":"ITEM_LISTING1","sections":{"rowIndex":1,"colIndex":1,"sections":[{"rowIndex":1,"colIndex":1,"sectionId":"cUtwCr6669NEWR2m","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","regex":"","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"t5","label":"11a5851d-f2c1-4ba5-9239-0fe672ccbe69","type":"select","subType":"select","regex":"","constraint":"MANDATORY","key":"","lov":"97add0d9-1a69-4aca-87d0-3b5e43765c4f","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"97add0d9-1a69-4aca-87d0-3b5e43765c4f"}],"secondaryEntityName":null,"secondaryValueMember":null,"secondaryDisplayMember":null,"nodeHierarchy":null}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t5","nodeHierarchy":"Item.attr","defaultValue":""},{"id":"locId","label":"LOCATION","type":"select","subType":"select","constraint":"MANDATORY","dataSource":[{"entityName":"location","valueMember":"locId","displayMember":"name","sorting":[{"name":"asc","reverse":true}],"filters":[]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"locId","nodeHierarchy":"Item","defaultValue":""},{"id":"t9","label":"ce9322e5-7e16-4e6e-89b9-8e3447b062e0","type":"checkbox","subType":"checkbox","regex":"","constraint":"OPTIONAL","key":"","lov":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b"}],"secondaryEntityName":null,"secondaryValueMember":null,"secondaryDisplayMember":null,"nodeHierarchy":null}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t9","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2},{"rowIndex":1,"colIndex":2,"sectionId":"02eGI8eFVOoZyiWc","definition":[{"id":"t2","label":"a3e80999-e85a-4eab-9076-facbff5a227d","type":"text","subType":"text","regex":"","constraint":"REQUIRED","key":"S","lov":"","delim":"","mapAttr":"","dataSource":[],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t2","nodeHierarchy":"Item.specAttr","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"OPTIONAL","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":1,"sectionId":"NEMfilc5QNcp2S4J","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","regex":"","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"costCode","label":"PURCHASE_COST_CENTER","type":"text","subType":"text","regex":"","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"costCode","nodeHierarchy":"Item","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":2,"sectionId":"xsPc6mnYdVh0f2qx","definition":[{"id":"container1","label":"navigationContainer1","type":"navigationContainer","subType":"navigationContainer","constraint":"MANDATORY","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"container1","nodeHierarchy":"Item","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"REQUIRED","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2}],"row":2,"cols":2}}]},"status":{"messageList":[],"messageCode":1200}}';
//    // String defiData = '{"data":{"projectId":11103,"FORM":[{"rows":1,"cols":1,"formId":"fdf07735-6c31-4f49-a31f-ff86bb5e0259","formLabel":"ITEM_LISTING1","sections":{"rowIndex":1,"colIndex":1,"sections":[{"rowIndex":1,"colIndex":1,"sectionId":"cUtwCr6669NEWR2m","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"t5","label":"11a5851d-f2c1-4ba5-9239-0fe672ccbe69","type":"select","subType":"select","regex":"","constraint":"MANDATORY","key":"","lov":"97add0d9-1a69-4aca-87d0-3b5e43765c4f","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"97add0d9-1a69-4aca-87d0-3b5e43765c4f"}],"secondaryEntityName":null,"secondaryValueMember":null,"secondaryDisplayMember":null,"nodeHierarchy":null}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t5","nodeHierarchy":"Item.attr","defaultValue":""},{"id":"locId","label":"LOCATION","type":"select","subType":"select","constraint":"MANDATORY","dataSource":[{"entityName":"location","valueMember":"locId","displayMember":"name","sorting":[{"name":"asc","reverse":true}],"filters":[]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"locId","nodeHierarchy":"Item","defaultValue":""}],"rowSpan":1,"colSpan":2},{"rowIndex":1,"colIndex":2,"sectionId":"02eGI8eFVOoZyiWc","definition":[{"id":"t2","label":"a3e80999-e85a-4eab-9076-facbff5a227d","type":"text","subType":"text","regex":"","constraint":"MANDATORY","key":"S","lov":"","delim":"","mapAttr":"","dataSource":[],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t2","nodeHierarchy":"Item.specAttr","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"OPTIONAL","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":1,"sectionId":"NEMfilc5QNcp2S4J","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"costCode","label":"PURCHASE_COST_CENTER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"costCode","nodeHierarchy":"Item","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":2,"sectionId":"xsPc6mnYdVh0f2qx","definition":[{"id":"container1","label":"navigationContainer1","type":"navigationContainer","subType":"navigationContainer","constraint":"MANDATORY","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"container1","nodeHierarchy":"Item","defaultValue":""},{"id":"t9","label":"ce9322e5-7e16-4e6e-89b9-8e3447b062e0","type":"checkbox","subType":"checkbox","regex":"","constraint":"OPTIONAL","key":"","lov":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b"}],"secondaryEntityName":null,"secondaryValueMember":null,"secondaryDisplayMember":null,"nodeHierarchy":null}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t9","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2}],"row":2,"cols":2}}]},"status":{"messageList":[],"messageCode":1200}}';
//    defiDataResp = json.decode(widget.defiData);
//    return FutureBuilder(
//        future: getComponentsData(defiDataResp, context, theKeys),
//        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//          if (!snapshot.hasData) return ListView(children: childList(defiDataResp,context,theKeys));
//          // for(int i=0;i<keys.length;i++) {getSizes(keys[i], i);}
//          for(int i=0;i<theKeys.length;i++) {
//            for(int j=0;j<theKeys[i].length;j++) {
//              getSizes(theKeys[i][j], i, j);
//            }
//          }
//          return ListView(children: childList(defiDataResp,context,theKeys));
//        }
//    );
//  }
//
//
//Future<dynamic> getComponentsData(dynamic data, context, List<List<GlobalKey>> keys) async {
//  await Future.delayed(Duration(seconds: 1));
//  return childList(data, context, keys);
//}
//
//List<Widget> childList(dynamic data, context, List<List<GlobalKey>> keys) {
//  List<Widget> listOfChildren = [];
//  int count = 0;
//  for(int i=0;i<data['sections'].length;i++) {
//    if(count==i) {
//      if(data['sections'][count]['colSpan']==2) {
//        dynamic sum = 0;
//        for(int j=0;j<theHeightsList[i].length;j++) {
//          sum += theHeightsList[i][j];
//        }
//        listOfChildren.add(
//            Container(
//              //  color: Colors.red[(count+1)*100],
//              // height: heightsList[i].toDouble(),
//              height: sum.toDouble(),
//              width: width,
//              child: GridView.count(
//                physics: NeverScrollableScrollPhysics(),
////                childAspectRatio: (width-20)/sum,
//                crossAxisCount: 1,
//                children: <Widget>[
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: childWidget(data, count, keys),
//                  )
//                ],
//              ),
//            )
//        );
//        count++;
//        sum = 0;
//        int lengthOfHeightList = theHeightsList[i].length;
//        theHeightsList[i].clear();
//        for(int j=0;j<lengthOfHeightList;j++) {
//          theHeightsList[i].add(0);
//        }
//      }else {
//        List<Widget> test = [];
//        test.addAll(childWidget(data, count+1, keys));
//        listOfChildren.add(
//            Container(
//              // color: Colors.blue[(count+1)*100],
//              height: ((height)/(data['row']+1))+38.0,
//              // height: heightsList[i].toDouble(),
//              width: width,
//              child: GridView.count(
//                physics: NeverScrollableScrollPhysics(),
//                crossAxisCount: 2,
////                childAspectRatio: 0.45,
//                children: <Widget>[
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: childWidget(data, count, keys),
//                  ),
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: childWidget(data, count+1, keys),
//                  )
//                ],
//              ),
//            )
//        );
//        count += 2;
//      }
//    }
//  }
//  return listOfChildren;
//}
//
//void getSizes(GlobalKey key, int sectionIndex, int widgetIndex) async {
//  if(key.currentContext!=null) {
//    RenderBox renderBox = key.currentContext.findRenderObject();
//    // heightsList[sectionIndex] = renderBox.size.height;
//    // heightsList[sectionIndex] += renderBox.size.height;
//    theHeightsList[sectionIndex][widgetIndex] += renderBox.size.height;
//  }
//}
//
//
//List<Widget> childWidget(dynamic data, int index, List<List<GlobalKey>> keys) {
//  List<Widget> listWidget = [];
//  for(int i=0;i<data['sections'][index]['definition'].length;i++) {
//    Map item = data['sections'][index]['definition'][i];
//    switch (item['type']) {
//      case "text": {
//        if(item['subType'] != 'date') {
//          listWidget.add(Padding(
//            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//            child: Container(
//              key: keys[index][i],
//              child: CustomText(
//                  item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
//                  formItems: data['sections'][index]['definition']
//              ),
//            ),
//          ));
//        }
//      }
//      break;
//      case "Password": {
//        if(item['subType'] != 'date') {
//          listWidget.add(Padding(child: CustomText(
//              item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
//              formItems: data['sections'][index]['definition']
//          ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0)));
//        }
//      }
//      break;
//      case "hidden": {
//        listWidget.add(Padding(
//          child: CustomHidden(
//              item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
//              formItems: data['sections'][index]['definition'], defaultValue: item['defaultValue']
//          ),
//          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
//        );
//      }
//      break;
//      case "radio": {
//        listWidget.add(Padding(child: Container(
//          key: keys[index][i],
//          child: CustomRadio(
//              item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//              formItems: data['sections'][index]['definition']
//          ),
//        ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0),));
//      }
//      break;
//      case "list": {
//        List<int> abc = [1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5];
//        listWidget.add(Padding(child: Container(
//          height: height,
//          key: keys[index][i],
//          child: ListView.builder(
//            itemCount: abc.length,
//            itemBuilder: (context, index) {
//              return ListTile(
//                title: Text(abc[index].toString()),
//              );
//            },
//          )
////          child: ListingView(
////
////          ),
//        ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0),));
//      }
//      break;
//      case "Switch": {
//        listWidget.add(Padding(child: CustomSwitch(
//            item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//            formItems: data['sections'][index]['definition']
//        ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0),));
//      }
//      break;
//      case "checkbox": {
//        listWidget.add(Padding(
//          child: Container(
//              key: keys[index][i],
//              child: CustomCheckBox(
//                  item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//                  formItems: data['sections'][index]['definition']
//              )),
//          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//        ));
//      }
//      break;
//      case "select": {
//        listWidget.add(
//            Padding(
//                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                child:Align(
//                  child: Container(
//                      key: keys[index][i],
//                      width: width,
//                      child: DropdownButtonHint(
//                        item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//                        formItems: data['sections'][index]['definition'],isEditTrue: widget.isEditTrue,defaultValue: widget.isEditTrue==true?widget.defaultData[item['id']]:" ",
//                      )
//                  ),
//                  alignment: Alignment.topLeft,
//                )
//            )
//        );
//      }
//      break;
//      case "date": {
//        listWidget.add(Padding(
//          child: CustomDatePicker(
//              item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//              formItems: data['sections'][index]['definition']
//          ),
//          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//        ));
//      }
//      break;
//      case "navigationContainer": {
//        listWidget.add(Padding(
//          child: Container(
//            key: keys[index][i],
//            child: CustomButton(
//              item: item,
//              wsId: wsId,
//            ),
//          ),
//          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//        ));
//      }
//      break;
//    }
//  }
//  return listWidget;
//}
//  String message(){
//    String msg=' ';
//    for(int i=0;i<defiDataResp['data']['FORM'][0]['sections']['sections'].length;i++) {
//      for(int j=0;j<defiDataResp['data']['FORM'][0]['sections']['sections'][i]['definition'].length;j++) {
//        Map item = defiDataResp['data']['FORM'][0]['sections']['sections'][i]['definition'][j];
//        if (item['type'] == 'text') {
//          if (item['response']== ""||item[i]['response']== null)
//          {
//            msg= msg + item['id'] + ' cannot be empty \n';
//            print(msg);
//          }
//        }
//
//      }
//
//      }
////      dynamic formItems=json.decode(json.encode("hjk"));
////    for( i=0;i<formItems.length;i++) {
////      if (formItems[i]['type'] == 'text') {
////        if (formItems[i]['response']== ""||formItems[i]['response']== null)
////        {
////          msg= msg + formItems[i]['id'] + ' cannot be empty \n';
////          print(msg);
////        }
////      }
////    }
//    if(msg==" ")
//      return msg;
//    else {
//      print(msg);
//      return msg;
////  ShowAlert(message: msg,);
//      // ShowAlert(message: msg,);
//    }
//  }
//String defaultValue(item){
//    if(widget.isEditTrue==true){
//      Map defaultDataMap= widget.defaultData as Map;
//     var hierarchyList = item['nodeHierarchy'].split('.');
//      if(hierarchyList.length==1)
//        {
//          return widget.defaultData['entityColName'];
//        }
//      else{
//        for(int i=hierarchyList.length-1;i>=0;i++)
//          {
//            if(defaultDataMap.containsKey(hierarchyList[i]))
//              {
//                var jsonData = json.decode(hierarchyList[i]);
//                print(jsonData);
//              }
//          }
//
//
//      }
//    }
//    else{
//      return " ";
//    }
//}
//}
//
//
//
//
//
//
//
//
//
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/forms/checkBox.dart';
import 'package:jupiter/forms/customDatepicker.dart';
import 'package:jupiter/forms/customDropdown.dart';
import 'package:jupiter/forms/customHiddenField.dart';
import 'package:jupiter/forms/formRendering.dart';
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
List<List<dynamic>> theHeightsList2 = [];


var db = DatabaseHelper();
var uuid = new Uuid();

class Gridxo extends StatefulWidget {
 String defiData;
 Gridxo({this.defiData});
  @override _MenusState createState() => _MenusState();
}

class _MenusState extends State<Gridxo> {
  @override void initState() {
    super.initState();
    myKeys.clear();
    defaultKeyNames.clear();
    theKeys.clear();
    sectionsList.clear();
    theHeightsList.clear();
//     widget.defiData = '{"data":{"projectId":11103,"FORM":[{"rows":1,"cols":1,"formId":"fdf07735-6c31-4f49-a31f-ff86bb5e0259","formLabel":"ITEM_LISTING1","sections":{"rowIndex":1,"colIndex":1,"sections":[{"rowIndex":1,"colIndex":1,"sectionId":"cUtwCr6669NEWR2m","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"t5","label":"11a5851d-f2c1-4ba5-9239-0fe672ccbe69","type":"select","subType":"select","regex":"","constraint":"MANDATORY","key":"","lov":"97add0d9-1a69-4aca-87d0-3b5e43765c4f","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"97add0d9-1a69-4aca-87d0-3b5e43765c4f"}],"secondaryEntityName":null,"secondaryValueMember":null,"secondaryDisplayMember":null,"nodeHierarchy":null}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t5","nodeHierarchy":"Item.attr","defaultValue":""},{"id":"locId","label":"LOCATION","type":"select","subType":"select","constraint":"MANDATORY","dataSource":[{"entityName":"location","valueMember":"locId","displayMember":"name","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"parentLocId","value":"##typeId"}],"toLook":"parentLocId"}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"locId","nodeHierarchy":"Item","defaultValue":""},{"id":"t9","label":"ce9322e5-7e16-4e6e-89b9-8e3447b062e0","type":"checkbox","subType":"checkbox","regex":"","constraint":"OPTIONAL","key":"","lov":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b"}],"secondaryEntityName":null,"secondaryValueMember":null,"secondaryDisplayMember":null,"nodeHierarchy":null}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t9","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2},{"rowIndex":1,"colIndex":2,"sectionId":"02eGI8eFVOoZyiWc","definition":[{"id":"t2","label":"a3e80999-e85a-4eab-9076-facbff5a227d","type":"text","subType":"text","regex":"","constraint":"MANDATORY","key":"S","lov":"","delim":"","mapAttr":"","dataSource":[],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t2","nodeHierarchy":"Item.specAttr","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"OPTIONAL","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":1,"sectionId":"NEMfilc5QNcp2S4J","definition":[{"id":"projectNumber","label":"PURCHASE_PROJECT_NUMBER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"projectNumber","nodeHierarchy":"Item","defaultValue":""},{"id":"costCode","label":"PURCHASE_COST_CENTER","type":"text","subType":"text","constraint":"OPTIONAL","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"costCode","nodeHierarchy":"Item","defaultValue":""}],"rowSpan":1,"colSpan":1},{"rowIndex":2,"colIndex":2,"sectionId":"xsPc6mnYdVh0f2qx","definition":[{"id":"container1","label":"navigationContainer1","type":"navigationContainer","subType":"navigationContainer","constraint":"MANDATORY","currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"sort":0,"entityName":"Item","entityColName":"container1","nodeHierarchy":"Item","defaultValue":""},{"id":"t8","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","type":"radio","subType":"radio","regex":"","constraint":"OPTIONAL","key":"","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","delim":"","mapAttr":"","dataSource":[{"entityName":"lov","valueMember":"id","displayMember":"value","sorting":[{"name":"asc","reverse":true}],"filters":[{"key":"domainGroup","value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37"}]}],"currentDate":false,"visibleInGrid":false,"visibleInFilter":false,"additionalSpecs":false,"qty":false,"copy":false,"dependentOn":"","triggerCheck":"","lovType":"S","sort":0,"entityName":"Item","entityColName":"t8","nodeHierarchy":"Item.attr","defaultValue":""}],"rowSpan":1,"colSpan":2}],"row":2,"cols":2}}]},"status":{"messageList":[],"messageCode":1200}}';
//    widget.defiData = '{"colIndex":1,"rowIndex":1,"row":2,"cols":2,"sections":[{"rowSpan":1,"colSpan":2,"colIndex":1,"rowIndex":1,"definition":[{"visibleInFilter":false,"defaultValue":"","currentDate":false,"label":"PURCHASE_PROJECT_NUMBER","sort":0,"type":"text","entityColName":"projectNumber","regex":"","nodeHierarchy":"Item","entityName":"Item","subType":"text","constraint":"OPTIONAL","id":"projectNumber","visibleInGrid":false,"additionalSpecs":false},{"defaultValue":"","currentDate":false,"type":"select","lov":"97add0d9-1a69-4aca-87d0-3b5e43765c4f","dependentOn":"","entityName":"Item","id":"t5","copy":false,"lovType":"S","key":"","delim":"","visibleInFilter":false,"triggerCheck":"","label":"11a5851d-f2c1-4ba5-9239-0fe672ccbe69","sort":0,"entityColName":"t5","regex":"","nodeHierarchy":"Item.attr","qty":false,"subType":"select","constraint":"MANDATORY","mapAttr":"","visibleInGrid":false,"additionalSpecs":false,"dataSource":[{"entityName":"lov","sorting":[{"name":"asc","reverse":true}],"valueMember":"id","filters":[{"value":"97add0d9-1a69-4aca-87d0-3b5e43765c4f","key":"domainGroup"}],"displayMember":"value"}]},{"visibleInFilter":false,"defaultValue":"","currentDate":false,"label":"LOCATION","sort":0,"type":"select","entityColName":"locId","nodeHierarchy":"Item","entityName":"Item","subType":"select","constraint":"MANDATORY","id":"locId","visibleInGrid":false,"additionalSpecs":false,"dataSource":[{"entityName":"location","sorting":[{"name":"asc","reverse":true}],"valueMember":"locId","filters":[],"displayMember":"name"}]},{"defaultValue":"","currentDate":false,"type":"checkbox","lov":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b","dependentOn":"","entityName":"Item","id":"t9","copy":false,"lovType":"S","key":"","delim":"","visibleInFilter":false,"triggerCheck":"","label":"ce9322e5-7e16-4e6e-89b9-8e3447b062e0","sort":0,"entityColName":"t9","regex":"","nodeHierarchy":"Item.attr","qty":false,"subType":"checkbox","constraint":"OPTIONAL","mapAttr":"","visibleInGrid":false,"additionalSpecs":false,"dataSource":[{"entityName":"lov","sorting":[{"name":"asc","reverse":true}],"valueMember":"id","filters":[{"value":"8f035973-4cbd-4ceb-9630-6c3ef0ae172b","key":"domainGroup"}],"displayMember":"value"}]}],"sectionId":""},{"rowSpan":1,"colSpan":1,"colIndex":2,"rowIndex":1,"definition":[{"defaultValue":"","currentDate":false,"type":"text","lov":"","dependentOn":"","entityName":"Item","id":"t2","copy":false,"lovType":"S","key":"S","delim":"","visibleInFilter":false,"triggerCheck":"","label":"a3e80999-e85a-4eab-9076-facbff5a227d","sort":0,"entityColName":"t2","regex":"","nodeHierarchy":"Item.specAttr","qty":false,"subType":"text","constraint":"REQUIRED","mapAttr":"","visibleInGrid":false,"additionalSpecs":false,"dataSource":[]},{"defaultValue":"","currentDate":false,"type":"radio","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","dependentOn":"","entityName":"Item","id":"t8","copy":false,"lovType":"S","key":"","delim":"","visibleInFilter":false,"triggerCheck":"","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","sort":0,"entityColName":"t8","regex":"","nodeHierarchy":"Item.attr","qty":false,"subType":"radio","constraint":"OPTIONAL","mapAttr":"","visibleInGrid":false,"additionalSpecs":false,"dataSource":[{"entityName":"lov","sorting":[{"name":"asc","reverse":true}],"valueMember":"id","filters":[{"value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","key":"domainGroup"}],"displayMember":"value"}]}],"sectionId":""},{"rowSpan":1,"colSpan":1,"colIndex":1,"rowIndex":2,"definition":[{"visibleInFilter":false,"defaultValue":"","currentDate":false,"label":"PURCHASE_PROJECT_NUMBER","sort":0,"type":"text","entityColName":"projectNumber","regex":"","nodeHierarchy":"Item","entityName":"Item","subType":"text","constraint":"OPTIONAL","id":"projectNumber","visibleInGrid":false,"additionalSpecs":false},{"visibleInFilter":false,"defaultValue":"","currentDate":false,"label":"PURCHASE_COST_CENTER","sort":0,"type":"text","entityColName":"costCode","regex":"","nodeHierarchy":"Item","entityName":"Item","subType":"text","constraint":"OPTIONAL","id":"costCode","visibleInGrid":false,"additionalSpecs":false}],"sectionId":""},{"rowSpan":1,"colSpan":2,"colIndex":2,"rowIndex":2,"definition":[{"visibleInFilter":false,"defaultValue":"","currentDate":false,"label":"navigationContainer1","sort":0,"type":"navigationContainer","entityColName":"container1","nodeHierarchy":"Item","entityName":"Item","subType":"navigationContainer","constraint":"MANDATORY","id":"container1","visibleInGrid":false,"additionalSpecs":false},{"defaultValue":"","currentDate":false,"type":"radio","lov":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","dependentOn":"","entityName":"Item","id":"t8","copy":false,"lovType":"S","key":"","delim":"","visibleInFilter":false,"triggerCheck":"","label":"a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13","sort":0,"entityColName":"t8","regex":"","nodeHierarchy":"Item.attr","qty":false,"subType":"radio","constraint":"REQUIRED","mapAttr":"","visibleInGrid":false,"additionalSpecs":false,"dataSource":[{"entityName":"lov","sorting":[{"name":"asc","reverse":true}],"valueMember":"id","filters":[{"value":"34fdde06-32c3-4778-bb0f-9cf0eec10a37","key":"domainGroup"}],"displayMember":"value"}]}],"sectionId":""}]}';
    defiDataResp = json.decode(widget.defiData);
    String keyName;
    int sections = 0;
    for(int i=0;i<defiDataResp['sections'].length;i++) {
      for(int j=0;j<defiDataResp['sections'][i]['definition'].length;j++) {
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
          if(checker==0) {
            theHeightsList2 = theHeightsList;
          }
          theHeightsList = theHeightsList2;
          checker++;
          return ListView(children: childList(defiDataResp,context,theKeys));
        }
    );
  }
}

void getSizes(GlobalKey key, int sectionIndex, int widgetIndex) async {
  if(key.currentContext!=null) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    theHeightsList[sectionIndex][widgetIndex] += renderBox.size.height;
  }
}

Future<dynamic> getComponentsData(dynamic data, context, List<List<GlobalKey>> keys) async {
  await Future.delayed(Duration(seconds: 1));
  return childList(data, context, keys);
}

List<Widget> childList(dynamic data, context, List<List<GlobalKey>> keys) {
  List<Widget> listOfChildren = [];
  int count = 0;
  for(int i=0;i<data['sections'].length;i++) {
    if(count==i) {
      dynamic sum = 0;
      for(int j=0;j<theHeightsList[i].length;j++) {
        sum += theHeightsList[i][j];
      }
      if(data['sections'][count]['colSpan']==2) {
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
  return listOfChildren;
}

List<Widget> childWidget(dynamic data, int index, List<List<GlobalKey>> keys) {
  List<Widget> listWidget = [];
  for(int i=0;i<data['sections'][index]['definition'].length;i++) {
    Map item = data['sections'][index]['definition'][i];
    switch (item['type']) {
      case "text": {
        if(item['subType'] != 'date') {
          listWidget.add(Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              key: keys[index][i],
              child: CustomText(
                  item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
                  formItems: data['sections'][index]['definition']
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
              formItems: data['sections'][index]['definition']
          ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0)));
        }
      }
      break;
      case "hidden": {
        listWidget.add(Padding(
          child: CustomHidden(
              item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
              formItems: data['sections'][index]['definition'], defaultValue: item['defaultValue']
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
              formItems: data['sections'][index]['definition']
          ),
        ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0),));
      }
      break;
      case "Switch": {
        listWidget.add(Padding(child: CustomSwitch(
            item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
            formItems: data['sections'][index]['definition']
        ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0),));
      }
      break;
      case "checkbox": {
        listWidget.add(Padding(
          child: Container(
              key: keys[index][i],
              child: CustomCheckBox(
                  item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
                  formItems: data['sections'][index]['definition']
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
                        formItems: data['sections'][index]['definition'],
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
              formItems: data['sections'][index]['definition']
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


//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------




//List<Widget> childList2(dynamic data, context, List<List<GlobalKey>> keys) {
//  List<Widget> listOfChildren = [];
//  int count = 0;
//  for(int i=0;i<data['data']['FORM'][0]['sections']['sections'].length;i++) {
//    if(count==i) {
//      dynamic sum = 0;
//      for(int j=0;j<theHeightsList2[i].length;j++) {
//        sum += theHeightsList2[i][j];
//      }
//      if(data['data']['FORM'][0]['sections']['sections'][count]['colSpan']==2) {
//        print(theHeightsList2);
//        listOfChildren.add(
//            Container(
//              height: sum.toDouble(),
//              width: width,
//              child: GridView.count(
//                physics: NeverScrollableScrollPhysics(),
//                childAspectRatio: (width-20)/sum,
//                crossAxisCount: 1,
//                children: <Widget>[
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: childWidget2(data, count),
//                  )
//                ],
//              ),
//            )
//        );
//        count++;
//      }else {
//        dynamic sum2 = 0;
//        for(int j=0;j<theHeightsList2[count+1].length;j++) {
//          sum2 += theHeightsList2[count+1][j];
//        }
//        if(sum2>sum) sum = sum2;
//        List<Widget> test = [];
//        test.addAll(childWidget2(data, count+1));
//        print(theHeightsList2);
//        listOfChildren.add(
//            Container(
//              height: sum.toDouble(),
//              width: width,
//              child: GridView.count(
//                physics: NeverScrollableScrollPhysics(),
//                crossAxisCount: 2,
//                childAspectRatio: 0.45,
//                children: <Widget>[
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: childWidget2(data, count),
//                  ),
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: childWidget2(data, count+1),
//                  )
//                ],
//              ),
//            )
//        );
//        count += 2;
//        sum2 = 0;
//      }
//      sum = 0;
//    }
//  }
//  return listOfChildren;
//}
//
//List<Widget> childWidget2(dynamic data, int index) {
//  List<Widget> listWidget = [];
//  for(int i=0;i<data['sections'][index]['definition'].length;i++) {
//    Map item = data['sections'][index]['definition'][i];
//    switch (item['type']) {
//      case "text": {
//        if(item['subType'] != 'date') {
//          listWidget.add(Padding(
//            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//            child: Container(
//              // key: keys[index][i],
//              child: CustomText(
//                  item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
//                  formItems: data['sections'][index]['definition']
//              ),
//            ),
//          ));
//        }
//      }
//      break;
//      case "Password": {
//        if(item['subType'] != 'date') {
//          listWidget.add(Padding(child: CustomText(
//              item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
//              formItems: data['sections'][index]['definition']
//          ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0)));
//        }
//      }
//      break;
//      case "hidden": {
//        listWidget.add(Padding(
//          child: CustomHidden(
//              item: item, count: i, onChanged: (dynamic response) {responseDetails=response;},
//              formItems: data['sections'][index]['definition'], defaultValue: item['defaultValue']
//          ),
//          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
//        );
//      }
//      break;
//      case "radio": {
//        listWidget.add(Padding(child: Container(
//          // key: keys[index][i],
//          child: CustomRadio(
//              item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//              formItems: data['sections'][index]['definition']
//          ),
//        ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0),));
//      }
//      break;
//      case "Switch": {
//        listWidget.add(Padding(child: CustomSwitch(
//            item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//            formItems: data['sections'][index]['definition']
//        ),padding: EdgeInsets.fromLTRB(10, 0, 10, 0),));
//      }
//      break;
//      case "checkbox": {
//        listWidget.add(Padding(
//          child: Container(
//            // key: keys[index][i],
//              child: CustomCheckBox(
//                  item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//                  formItems: data['sections'][index]['definition']
//              )),
//          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//        ));
//      }
//      break;
//      case "select": {
//        listWidget.add(
//            Padding(
//                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                child:Align(
//                  child: Container(
//                    // key: keys[index][i],
//                      width: width,
//                      child: DropdownButtonHint(
//                        item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//                        formItems: data['sections'][index]['definition'],
//                      )
//                  ),
//                  alignment: Alignment.topLeft,
//                )
//            )
//        );
//      }
//      break;
//      case "date": {
//        listWidget.add(Padding(
//          child: CustomDatePicker(
//              item: item, count: i, onChanged: (dynamic response) {responseDetails = response;},
//              formItems: data['sections'][index]['definition']
//          ),
//          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//        ));
//      }
//      break;
//      case "navigationContainer": {
//        listWidget.add(Padding(
//          child: Container(
//            //  key: keys[index][i],
//            child: CustomButton(
//              item: item,
//              wsId: wsId,
//            ),
//          ),
//          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//        ));
//      }
//      break;
//    }
//  }
//  return listWidget;
//}