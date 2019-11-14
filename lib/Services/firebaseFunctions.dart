import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:jupiter/Constant/stringConstant.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Models/models.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/Screens/Views/signIn.dart';
import 'package:jupiter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'jupiterUtlis.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


String notifResponse = "";
String contentDb;
List<Map<String, dynamic>> result = [];
List<Map<String, dynamic>> parameter = [];
dynamic responseApi;
var db = new DatabaseHelper();
final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
Future<void> getDatafromFirebase(context) async {
  firebaseMessaging.configure(
    onMessage: (dynamic response) async {
      var notifResponse;
      if(Platform.isAndroid) notifResponse = json.decode(response[responseData]["data"].toString());
      else if(Platform.isIOS) notifResponse = json.decode(response[responseData].toString());
      for(int i=0;i<notifResponse.length;i++) {
        db.populateTableWithMapping(notificationTable, notifResponse[i],true);
      }
    },
  );
}

void getProjectData() async {
  //Fetch Notification Data From Database
  result = await db.fetchInitNotificationRecords();
  if (result.length == 0){result = await db.fetchInitNotificationRecordsForDefaultProject();}
  if(result.length == 0) {result = await db.fetchFirstProject();}

  for(int i=0;i<result.length;i++) {
    print(result[i][parameters]);
    parameter.add(json.decode(result[i][parameters]));
    parameter[i].forEach((k,v) {
      String key = k;
      parameter[i][key] = result[i][k];
    });
    parameter[i]["timestamp"] = -1;
    int checkTableExistance = await db.checkIfTableExist(result[i]["message"],true);
//    int checkTableExistance = await db.checkIfTableExist(result[i]["message"],false);
    if(result[i]["message"]=="MODEL") {
      responseApi = await callApi(result[i][modelUri], parameter[i].toString());
      // responseApi = '{"data":{"MODEL":[{"modelName":"ITEM","formId":"1","tableColumns":[{"columnName":"id","dataType":"String","primaryKey":true,"precision":null,"scale":null,"maxLength":null},{"columnName":"locId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"parentLocId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"catId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"specAttr","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"attr","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"cKey","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"typeId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"tagDoc","dataType":"int","primaryKey":false,"precision":18,"scale":4,"maxLength":18},{"columnName":"tagAttr","dataType":"int","primaryKey":false,"precision":18,"scale":4,"maxLength":18},{"columnName":"status","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"state","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"availability","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"projectNumber","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"costCode","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"projectIdentifierType","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null}]},{"modelName":"LOCATION","formId":"2","tableColumns":[{"columnName":"locId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"parentLocId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"code","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"name","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"attr","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"projectNumbers","dataType":"List","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"costCodes","dataType":"List","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"type","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"sys","dataType":"boolean","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"status","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"createdBy","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"createdDt","dataType":"Long","primaryKey":false,"precision":18,"scale":4,"maxLength":18},{"columnName":"updatedBy","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"updatedDt","dataType":"Long","primaryKey":false,"precision":18,"scale":4,"maxLength":18}]},{"modelName":"CATEGORY","formId":"3","tableColumns":[{"columnName":"categoryId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"parentId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"type","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"templateId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"templateIdMob","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"code","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"name","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"bulkReserve","dataType":"boolean","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"status","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"createdBy","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"createdDt","dataType":"Long","primaryKey":false,"precision":18,"scale":4,"maxLength":18},{"columnName":"updatedBy","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"updatedDt","dataType":"Long","primaryKey":false,"precision":18,"scale":4,"maxLength":18}]},{"modelName":"LOV","formId":"4","tableColumns":[{"columnName":"id","dataType":"Json","primaryKey":true,"precision":null,"scale":null,"maxLength":null},{"columnName":"entity","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"group","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"groupCode","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"value","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"relValue","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"sValue","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"seqNo","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"numericValue","dataType":"boolean","primaryKey":false,"precision":null,"scale":null,"maxLength":null}]},{"modelName":"ITEMTYPE","formId":"5","tableColumns":[{"columnName":"itemTypeId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"categoryId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"category","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"code","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"name","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"attr","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"threshold","dataType":"boolean","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"thresholdDefaultValue","dataType":"double","primaryKey":false,"precision":18,"scale":4,"maxLength":18},{"columnName":"thresholdType","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"status","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"createdBy","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"createdDt","dataType":"Long","primaryKey":false,"precision":18,"scale":4,"maxLength":18},{"columnName":"updatedBy","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"updatedDt","dataType":"Long","primaryKey":false,"precision":18,"scale":4,"maxLength":18}]},{"modelName":"TEMPLATE","formId":"6","tableColumns":[{"columnName":"templateId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"templateMobId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"categoryId","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"subCategory","dataType":"Category","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"definition","dataType":"List","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"cKeySeq","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"scanner","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"nextSeq","dataType":"Integer","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"qualification","dataType":"boolean","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"relevantQualification","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"tag","dataType":"boolean","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"sort","dataType":"boolean","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"specDefn","dataType":"List","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"docType","dataType":"Json","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"type","dataType":"String","primaryKey":false,"precision":null,"scale":null,"maxLength":null},{"columnName":"createdBy","dataType":"long","primaryKey":false,"precision":18,"scale":4,"maxLength":18},{"columnName":"createdDt","dataType":"Long","primaryKey":false,"precision":18,"scale":4,"maxLength":18},{"columnName":"updatedBy","dataType":"long","primaryKey":false,"precision":18,"scale":4,"maxLength":18},{"columnName":"updatedDt","dataType":"Long","primaryKey":false,"precision":18,"scale":4,"maxLength":18}]}],"projectId":11103},"status":{"messageList":[],"messageCode":1200}}';
      final responseOfApi = json.decode(responseApi.body);
      ModelReponseModel modelReponseModel = new ModelReponseModel.fromJson(responseOfApi);
      List<String> columnNames = [];
      List<String> columnDataTypes = [];
      List<String> primaryKey = [];
      for(int j=0;j<modelReponseModel.modelDataModel.models.length;j++) {
        for(int k=0;k<modelReponseModel.modelDataModel.models[j].tableColumns.length;k++) {
          if(modelReponseModel.modelDataModel.models[j].tableColumns[k].primaryKey == true) {
            primaryKey.add(modelReponseModel.modelDataModel.models[j].tableColumns[k].columnName);
          }
          columnNames.add(modelReponseModel.modelDataModel.models[j].tableColumns[k].columnName);
          columnDataTypes.add(modelReponseModel.modelDataModel.models[j].tableColumns[k].dataType);
        }
        db.createContentTable(modelReponseModel.modelDataModel.models[j].modelName, columnNames, columnDataTypes, primaryKey);
        await Future.delayed(Duration(seconds: 2));
        columnNames.clear();
        columnDataTypes.clear();
        primaryKey.clear();
        var buffer = await db.fetchTablesData(false);
        // for(int i=0;i<buffer.length;i++) {fetchedContentTableData.add(buffer[i]['name']);}
        fetchedContentTableData.add(modelReponseModel.modelDataModel.models[j].modelName);
      }
    }else if(checkTableExistance != 0) {
      responseApi = await callApi(result[i][modelUri], parameter[i].toString());
      final responseOfApi = json.decode(responseApi.body);
      if(result[i]["message"]=="DEFINITION") {
        DefinitionResponseModel definitionResponseModel = new DefinitionResponseModel.fromJson(responseOfApi);
        for(int j=0;j<definitionResponseModel.definitionDataModel.definition.length;j++) {
          db.populateTableWithCustomColumn(result[i]["message"], definitionResponseModel.definitionDataModel.definition[j].toMap(), "projectId", definitionResponseModel.definitionDataModel.projectId,true);
        }
      }
      else if(result[i]['message']=="WORKSPACE") {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        responseApi = await callApi(result[i][modelUri], parameter[i].toString());
        // responseApi = '{"data":{"WORKSPACE":[{"defaultFormId":"98240c0d-8c4d-4305-a396-bba71bbacb2b","wsId":"save_Item","wsName":"SAVE ITEM","navigationMapping":[{"formId":"98240c0d-8c4d-4305-a396-bba71bbacb2b","buttonId":"button_save","componentType":"button","componentSubType":"button","redirectFormId":"","redirectSectionId":"","label":"Save","operation":"SAVE","containerId":"container1","redirectWsId":"save_Item"},{"formId":"98240c0d-8c4d-4305-a396-bba71bbacb2b","buttonId":"button_close","componentType":"button","componentSubType":"button","redirectFormId":"","redirectSectionId":"","label":"Close","operation":"CLOSE","containerId":"container1","redirectWsId":"save_Item"}],"Relations":[{"ParentTableName":"ITEM","Relation":[{"ChildEntityName":"DOCS","ReferenceColumnName":"id","ChildReferenceColumnName":"itemId"}]}],"rootEntityName":"ITEM","rootEntityColName":"id","copy":[{"entityCol":"","entityVal":""}],"preReq":[{"col":"","val":""}]}],"projectId":11103},"status":{"messageList":[],"messageCode":1200}}';
        final responseOfApi = json.decode(responseApi.body);
        WorkSpaceResponseModel workSpaceResponseModel = new WorkSpaceResponseModel.fromJson(responseOfApi);
        for (int i = 0; i < workSpaceResponseModel.data.workSpace.length; i++) {
          db.populateTableWithMapping("WORKSPACE", workSpaceResponseModel.data.workSpace[i].toMap(),true);
          for (int j=0;j<workSpaceResponseModel.data.workSpace[i].navigationMapping.length;j++)
            db.populateTableWithCustomColumn("NAVIGATION_MAPPING",workSpaceResponseModel.data.workSpace[i].navigationMapping[j].toMap() , "wsId", workSpaceResponseModel.data.workSpace[i].wsId,true);
          for(int j=0;j<workSpaceResponseModel.data.workSpace[i].relations.length;j++)
            db.multiplePopulateTableWithCustomColumn("RELATIONS", workSpaceResponseModel.data.workSpace[i].relations[j].toMap(), ["userId","projectId","wsId"], [sharedPreferences.get("userId"),workSpaceResponseModel.data.projectId,workSpaceResponseModel.data.workSpace[i].wsId], true);
        }
      }
      else {
        GenericResponseModel genericResponseModel = new GenericResponseModel.fromJson(responseOfApi, result[i]["message"]);
        for(int j=0;j<genericResponseModel.genericDataModel.genericModel.length;j++) {
          db.populateTableWithCustomColumn(result[i]["message"], genericResponseModel.genericDataModel.genericModel[j].generic,"projectId",genericResponseModel.genericDataModel.projectId,true);
        }
      }

    }else {
    responseApi = await callApi(result[i][modelUri], parameter[i].toString());
    final responseOfApi = json.decode(responseApi.body);
    GenericResponseModel genericResponseModel = new GenericResponseModel.fromJson(responseOfApi, result[i]["message"]);
      for(int j=0;j<genericResponseModel.genericDataModel.genericModel.length;j++) {
        genericResponseModel.genericDataModel.genericModel[j].generic.putIfAbsent('syncStatus', () => 'false');
        db.populateTableWithMapping(result[i]["message"], genericResponseModel.genericDataModel.genericModel[j].generic,false);
      }
    }
  }
}

void saveMasterData(List<Map> result) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  for(int i=0;i<result.length;i++) {
    parameter.add(json.decode(result[i][parameters]));
    parameter[i].forEach((k,v) {
      String key = k;
      parameter[i][key] = result[i][k];
    });
    responseApi = await callApi(result[i][modelUri], parameter[i].toString());
    final responseOfApi = json.decode(responseApi.body);
    GenericResponseModel genericResponseModel = new GenericResponseModel.fromJson(responseOfApi, result[i]["message"]);
    for(int j=0;j<genericResponseModel.genericDataModel.genericModel.length;j++) {
      db.populateTableWithCustomColumn(result[i]["message"], genericResponseModel.genericDataModel.genericModel[j].generic,"projectId",genericResponseModel.genericDataModel.projectId,true);
    }

    //To save defaultProjectId in Persistent Storage
    for(int j=0;j<genericResponseModel.genericDataModel.genericModel.length;j++) {
      if(result[i]["message"] == "PROJECT" && genericResponseModel.genericDataModel.genericModel[j].generic["defaultProject"] == true) {
        sharedPreferences.setInt('projectId', genericResponseModel.genericDataModel.genericModel[j].generic["projectId"]);
        sharedPreferences.setString("contentDb", genericResponseModel.genericDataModel.genericModel[j].generic["db"]);
        contentDb = genericResponseModel.genericDataModel.genericModel[j].generic["db"];
        await db.dbContent;
        break;
      }
    }
    if(sharedPreferences.get('projectId') == null && result[i]["message"] == "PROJECT") {
      sharedPreferences.setInt('projectId', genericResponseModel.genericDataModel.genericModel[0].generic["projectId"]);
      contentDb = genericResponseModel.genericDataModel.genericModel[0].generic["db"];
      sharedPreferences.setString("contentDb", genericResponseModel.genericDataModel.genericModel[0].generic["db"]);
      await db.dbContent;
    }
  }
}

void checkIfDataIsStored(context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  db.checkDefinitionData().then((labelData) {
    if(labelData>0) {
      sharedPreferences.setBool("FirstTimeLogin", false);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Menus()));
    }else {checkIfDataIsStored(context);}
  });
}

Future<String> remoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: false));
  remoteConfig.setDefaults(<String, dynamic>{
    'baseURL': 'https://on.petroit.com/mozaic/services',
  });
  // await remoteConfig.fetch();
  await remoteConfig.activateFetched();
  return remoteConfig.getValue("baseURL").asString();
}


Future<String> summaryRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
 remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: false));
  remoteConfig.setDefaults(<String, dynamic>{
    'SUMMARY_UI_DATA': 'nil',
  });

  await remoteConfig.fetch();
  await remoteConfig.activateFetched();
  return remoteConfig.getValue("SUMMARY_UI_DATA").asString();

}


