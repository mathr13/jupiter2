import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:jupiter/Constant/string_constant.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/Models/models.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/Screens/Views/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'jupiter_utlis.dart';
String data = json.encode({
  "data": {
    "WORKSPACE": [{
      "defaultTemplateId": "Save Item",
      "wsId": "15356537dedfer",
      "wsName": "Save Item",
      "navigationMapping": [{
        "templateId": "Save Item",
        "buttonId": "save",
        "componentType": "button",
        "componentSubType": "button",
        "redirectTemplateId": "List Item",
        "label": "save",
        "operation": "save",
        "containerId": "P1"
      },
        {
          "templateId": "Save Item",
          "buttonId": "close",
          "componentType": "button",
          "componentSubType": "button",
          "redirectTemplateId": "Dashboard",
          "label": "close",
          "operation": "close",
          "containerId": "P1"
        }
      ]
    }],
    "projectId": 12345
  }
}
);
String notifResponse = "";
String contentDb;
int cunt = 1;
List<Map<String, dynamic>> result = [];
List<Map<String, dynamic>> parameter = [];
dynamic responseApi;
var db = new DatabaseHelper();

Future<void> getDatafromFirebase(context) async {
  firebaseMessaging.configure(
    onMessage: (dynamic response) async {
      var notifResponse;
      // print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      // print(response[responseData]["data"]);
      // print(cunt);
      // cunt++;
      if(Platform.isAndroid) {
        notifResponse = json.decode(response[responseData]["data"].toString());
      }else if(Platform.isIOS) {
        notifResponse = json.decode(response[responseData].toString());
      }
      for(int i=0;i<notifResponse.length;i++) {
        db.populateTableWithMapping(notificationTable, notifResponse[i]);
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
    parameter.add(json.decode(result[i][parameters]));
    parameter[i].forEach((k,v) {
      String key = k;
      parameter[i][key] = result[i][k];
    });
    parameter[i]["timestamp"] = -1;
    int checkTableExistance = await db.checkIfTableExist(result[i]["message"]);
    if(result[i]["message"]=="MODEL") {
      responseApi = await callApi(result[i][modelUri], parameter[i].toString());
      final responseOfApi = json.decode(responseApi.body);
      ModelReponseModel modelReponseModel = new ModelReponseModel.fromJson(responseOfApi);
      for(int j=0;j<modelReponseModel.modelDataModel.models.length;j++) {
        db.createTable(modelReponseModel.modelDataModel.models[j].modelName, modelReponseModel.modelDataModel.models[j].tableColumns[0].columnName, modelReponseModel.modelDataModel.models[j].tableColumns[0].dataType);
        for(int k=1;k<modelReponseModel.modelDataModel.models[j].tableColumns.length;k++) {
          if(k==1) {await Future.delayed(Duration(seconds: 1));}
          db.addColumnToTable(modelReponseModel.modelDataModel.models[j].modelName, modelReponseModel.modelDataModel.models[j].tableColumns[k].columnName, modelReponseModel.modelDataModel.models[j].tableColumns[k].dataType);
        }
        WorkSpaceDataModel workSpaceDataModel = new WorkSpaceDataModel.fromJson((json.decode(data))['data']);
        for (int i = 0; i < workSpaceDataModel.workSpace.length; i++) {
          db.populateTableWithMapping("WORKSPACE", workSpaceDataModel.workSpace[i].toMap());
          for (int j=0;j<workSpaceDataModel.workSpace[i].navigationMapping.length;j++)
            db.populateTableWithCustomColumn("NAVIGATION_MAPPING",workSpaceDataModel.workSpace[i].navigationMapping[j].toMap() , "wsId", workSpaceDataModel.workSpace[i].wsId);
        }
      }
    }else if(checkTableExistance != 0) {
      responseApi = await callApi(result[i][modelUri], parameter[i].toString());
      final responseOfApi = json.decode(responseApi.body);
      if(result[i]["message"]=="DEFINITION") {
        DefinitionResponseModel definitionResponseModel = new DefinitionResponseModel.fromJson(responseOfApi);
        for(int j=0;j<definitionResponseModel.definitionDataModel.definition.length;j++) {
          db.populateTableWithCustomColumn(result[i]["message"], definitionResponseModel.definitionDataModel.definition[j].toMap(), "projectId", definitionResponseModel.definitionDataModel.projectId);
        }
      }
      // else if(result[i]['message']=="WORKSPACE") {
      //   WorkSpaceDataModel workSpaceDataModel = new WorkSpaceDataModel.fromJson(
      //       data);
      //   for (int i = 0; i < workSpaceDataModel.workSpace.length; i++) {
      //     db.populateTableWithMapping(
      //         "WORKSPACE", workSpaceDataModel.workSpace[i].toMap());
      //     for (int j=0;j<workSpaceDataModel.workSpace[i].navigationMapping.length;j++)
      //       db.populateTableWithCustomColumn("NAVIGATION_MAPPING",workSpaceDataModel.workSpace[i].navigationMapping[j].toMap() , "wsId", workSpaceDataModel.workSpace[i].wsId);
      //   }
      // }
      else {
        GenericResponseModel genericResponseModel = new GenericResponseModel.fromJson(responseOfApi, result[i]["message"]);
        for(int j=0;j<genericResponseModel.genericDataModel.genericModel.length;j++) {
          db.populateTableWithCustomColumn(result[i]["message"], genericResponseModel.genericDataModel.genericModel[j].generic,"projectId",genericResponseModel.genericDataModel.projectId);
        }
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
      db.populateTableWithCustomColumn(result[i]["message"], genericResponseModel.genericDataModel.genericModel[j].generic,"projectId",genericResponseModel.genericDataModel.projectId);
    }

    //To save defaultProjectId in Persistent Storage
    for(int j=0;j<genericResponseModel.genericDataModel.genericModel.length;j++) {
      if(result[i]["message"] == "PROJECT" && genericResponseModel.genericDataModel.genericModel[j].generic["defaultProject"] == true) {
        sharedPreferences.setInt('projectId', genericResponseModel.genericDataModel.genericModel[j].generic["projectId"]);
        contentDb = genericResponseModel.genericDataModel.genericModel[j].generic["db"];
        await db.dbContent;
        break;
      }
    }
    if(sharedPreferences.get('projectId') == null && result[i]["message"] == "PROJECT") {
      sharedPreferences.setInt('projectId', genericResponseModel.genericDataModel.genericModel[0].generic["projectId"]);
      contentDb = genericResponseModel.genericDataModel.genericModel[0].generic["db"];
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
    }
    else {checkIfDataIsStored(context);}
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
  // await remoteConfig.fetch(expiration: const Duration(seconds: 1));
  await remoteConfig.activateFetched();
  return remoteConfig.getValue("baseURL").asString();
}