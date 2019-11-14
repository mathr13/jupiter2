import 'dart:convert';
class AuthenticationObject {
  UserData data;
  Status status;

  AuthenticationObject({this.data,this.status});

  factory AuthenticationObject.fromJson(Map<String,dynamic> parsedJson) {
    return AuthenticationObject(
        data: UserData.fromJson(parsedJson["data"]),
        status: Status.fromJson(parsedJson["status"])
    );
  }
}

class UserData {
  String firstName;
  String lastName;
  int userId;
  String language;

  UserData({this.firstName, this.lastName, this.language, this.userId});

  factory UserData.fromJson(Map<String, dynamic> parsedJson) {
    return UserData(
      firstName: parsedJson["firstName"],
      lastName: parsedJson["lastName"],
      userId: parsedJson["userId"],
      language: parsedJson["lang"],
    );
  }
  Map<dynamic, dynamic> toMap() {
    var map=new Map<String, dynamic>();
    map["firstname"]=firstName;
    map["lastname"]=lastName;
    map["userId"]=userId;
    map["lang"]=language;
    return map;
  }
}

class Status {
  List<Message> messageList;
  int messageCode;

  Status({this.messageCode,this.messageList});

  factory Status.fromJson(dynamic parsedJson) {
    var messageList = parsedJson["messageList"] as List;
    List<Message> listOfmessage = messageList.map((i) => Message.fromJson(i)).toList();
    return Status(
      messageList: listOfmessage,
      messageCode: parsedJson["messageCode"]
    );
  }
}

class Message {
  Message();
  factory Message.fromJson(dynamic parsedJson) {
    return Message();
  }
}


class GenericResponseModel {
  GenericDataModel genericDataModel;
  Status status;

  GenericResponseModel({this.genericDataModel,this.status});

  factory GenericResponseModel.fromJson(Map<String, dynamic> parsedJson, String itemName) {
    return GenericResponseModel(
      genericDataModel: GenericDataModel.fromJson(parsedJson["data"], itemName),
      status: Status.fromJson(parsedJson["status"])
    );
  }
}

class GenericDataModel {
  List<GenericModel> genericModel;
  int projectId;

  GenericDataModel({this.genericModel,this.projectId});

  factory GenericDataModel.fromJson(Map<String, dynamic> parsedJson, String itemName) {
    var genericModelList = parsedJson[itemName] as List;
    List<GenericModel> listOfGenericModel = genericModelList.map((i) => GenericModel.fromJson(i)).toList();
    return GenericDataModel(
      genericModel: listOfGenericModel,
      projectId: parsedJson["projectId"]
    );
  }
}

class GenericModel {
  Map<String, dynamic> generic;

  GenericModel({this.generic});

  factory GenericModel.fromJson(Map<String, dynamic> parsedJson) {
    return GenericModel(
      generic: parsedJson
    );
  }
}



class DefinitionResponseModel {
  DefinitionDataModel definitionDataModel;
  Status status;

  DefinitionResponseModel({this.definitionDataModel,this.status});

  factory DefinitionResponseModel.fromJson(dynamic parsedJson) {
    return DefinitionResponseModel(
      definitionDataModel: DefinitionDataModel.fromJson(parsedJson['data']),
      status: Status.fromJson(parsedJson['status'])
    );
  }
}

class DefinitionDataModel {
  List<DefinitionModel> definition;
  int projectId;

  DefinitionDataModel({this.definition,this.projectId});

  factory DefinitionDataModel.fromJson(dynamic parsedJson) {
    var definitionList = parsedJson["DEFINITION"] as List;
    List<DefinitionModel> listOfDefinition = definitionList.map((i) => DefinitionModel.fromJson(i)).toList();
    return DefinitionDataModel(
      definition: listOfDefinition,
      projectId: parsedJson['projectId']
    );
  }
}

class DefinitionModel {
  String formId;
  String name;
  String template;

  DefinitionModel({this.template,this.name,this.formId});

  factory DefinitionModel.fromJson(Map<String, dynamic> parsedJson) {
    return DefinitionModel(
      formId: parsedJson['formId'],
      name: parsedJson['name'],
      template:json.encode(parsedJson['template'])
    );
  }
  Map<dynamic, dynamic> toMap() {
    var map=new Map<String, dynamic>();
    map["formId"]=formId;
    map["name"]=name;
    map["template"]=template;
    return map;
  }
}


class ModelReponseModel {
  ModelDataModel modelDataModel;
  Status status;

  ModelReponseModel({this.modelDataModel,this.status});

  factory ModelReponseModel.fromJson(dynamic parsedJson) {
    return ModelReponseModel(
      modelDataModel: ModelDataModel.fromJson(parsedJson['data']),
      status: Status.fromJson(parsedJson['status'])
    );
  }
}

class ModelDataModel {
  int projectId;
  List<Model> models;

  ModelDataModel({this.projectId,this.models});

  factory ModelDataModel.fromJson(dynamic parsedJson) {
    var modelList = parsedJson["MODEL"] as List;
    List<Model> listOfModel = modelList.map((i) => Model.fromJson(i)).toList();
    return ModelDataModel(
      projectId: parsedJson['projectId'],
      models: listOfModel
    );
  }
}

class Model {
  String modelName;
  String formId;
  List<TableColumn> tableColumns;

  Model({this.formId,this.modelName,this.tableColumns});

  factory Model.fromJson(dynamic parsedJson) {
    var columnList = parsedJson["tableColumns"] as List;
    List<TableColumn> listOfColumn = columnList.map((i) => TableColumn.fromJson(i)).toList();
    return Model(
      formId: parsedJson['formId'],
      modelName: parsedJson['modelName'],
      tableColumns: listOfColumn
    );
  }
}

class TableColumn {
  String columnName;
  String dataType;
  bool primaryKey;
  double precision;
  double scale;
  double maxLength;

  TableColumn({this.columnName, this.dataType, this.primaryKey, this.precision, this.scale, this.maxLength});

  factory TableColumn.fromJson(Map<String, dynamic> parsedJson) {
    return TableColumn(
        columnName: parsedJson['columnName'],
        dataType: parsedJson['dataType'],
        primaryKey: parsedJson['primaryKey'],
        precision: parsedJson['precision'],
        scale: parsedJson['scale'],
        maxLength: parsedJson['maxLength']
    );
  }
}

class WorkSpaceResponseModel {
  WorkSpaceDataModel data;

  WorkSpaceResponseModel({this.data});

  factory WorkSpaceResponseModel.fromJson(dynamic parsedJson) {
    return WorkSpaceResponseModel(
      data: WorkSpaceDataModel.fromJson(parsedJson['data'])
    );
  }
}

class WorkSpaceDataModel{
  List<WorkSpaceModel> workSpace;
  int projectId;

  WorkSpaceDataModel({this.projectId,this.workSpace});

  factory WorkSpaceDataModel.fromJson(dynamic parsedJson) {
    var workspaceList = parsedJson["WORKSPACE"] as List;
    List<WorkSpaceModel> listOfWorkspace = workspaceList.map((i) => WorkSpaceModel.fromJson(i)).toList();
    return WorkSpaceDataModel(
        workSpace: listOfWorkspace,
        projectId: parsedJson['projectId']
    );
  }
}

class WorkSpaceModel{
  String defaultTemplateId;
  String wsId;
  String wsName;
  List<NavigationMapping> navigationMapping;
  List<Relations> relations;

  WorkSpaceModel({this.defaultTemplateId,this.wsId,this.wsName,this.navigationMapping,this.relations});

  factory WorkSpaceModel.fromJson(Map<String,dynamic> parsedJson){
    var navigationMappingList = parsedJson["navigationMapping"] as List;
    List<NavigationMapping> listOfNavigationMapping = navigationMappingList.map((i) => NavigationMapping.fromJson(i)).toList();
    var relationsList = parsedJson["relations"] as List;
    List<Relations> listOfrelations = relationsList.map((i) => Relations.fromJson(i)).toList();
    return WorkSpaceModel(
        defaultTemplateId: parsedJson['defaultFormId'],
        wsId: parsedJson['wsId'],
        wsName: parsedJson['wsName'],
      navigationMapping: listOfNavigationMapping,
      relations: listOfrelations,
    );
  }
  Map<dynamic, dynamic> toMap() {
    var map=new Map<String, dynamic>();
    map["defaultFormId"]=defaultTemplateId;
    map["wsId"]=wsId;
    map["wsName"]=wsName;
    return map;
  }
}

class NavigationMapping {
  String formId;
  String buttonId;
  String componentType;
  String componentSubType;
  String redirectFormId;
  String redirectSectionId;
  String label;
  String operation;
  String containerId;
  String redirectWsId;

  NavigationMapping({this.formId, this.buttonId, this.componentSubType, this.componentType, this.containerId, this.label, this.operation, this.redirectFormId,this.redirectSectionId,this.redirectWsId});

  factory NavigationMapping.fromJson(Map<String, dynamic> parsedJson){
    return NavigationMapping(
      formId: parsedJson['formId'],
      buttonId: parsedJson['buttonId'],
      componentType: parsedJson['componentType'],
      componentSubType: parsedJson['componentSubType'],
      redirectFormId: parsedJson['redirectFormId'],
      label: parsedJson['label'],
      operation: parsedJson['operation'],
      containerId: parsedJson['containerId'],
      redirectSectionId: parsedJson['redirectSectionId'],
      redirectWsId: parsedJson['redirectWsId']
    );
  }
  Map<dynamic, dynamic> toMap() {
    var map=new Map<String, dynamic>();
    map["formId"]=formId;
    map["buttonId"]=buttonId;
    map["componentType"]=componentType;
    map["componentSubType"]=componentSubType;
    map["redirectFormId"]=redirectFormId;
    map["label"]=label;
    map["operation"]=operation;
    map["containerId"]=containerId;
    map["redirectSectionId"]=redirectSectionId;
    map["redirectWsId"]=redirectWsId;
    return map;
  }
}

class Relations {
  String parentTableName;
  String childEntityName;
  String referenceColumnName;
  String childReferenceColumnName;

  Relations({this.parentTableName,this.childEntityName,this.referenceColumnName,this.childReferenceColumnName});

  factory Relations.fromJson(dynamic parsedJson) {
    var relationList = parsedJson["relation"] as List;
    List<Relation> listOfrelation = relationList.map((i) => Relation.fromJson(i)).toList();
    print(listOfrelation);
    return Relations(
      parentTableName: parsedJson['parentTableName'],
      childEntityName: listOfrelation[0].childEntityName,
      childReferenceColumnName: listOfrelation[0].childReferenceColumnName,
      referenceColumnName: listOfrelation[0].referenceColumnName,
    );
  }
  Map<dynamic, dynamic> toMap() {
    var map=new Map<String, dynamic>();
    map["parentTableName"]=parentTableName;
    map["childEntityName"]=childEntityName;
    map["referenceColumnName"]=referenceColumnName;
    map["childReferenceColumnName"]=childReferenceColumnName;
    return map;
  }
}

class Relation {
  String childEntityName;
  String referenceColumnName;
  String childReferenceColumnName;

  Relation({this.childEntityName,this.childReferenceColumnName,this.referenceColumnName});

  factory Relation.fromJson(dynamic parsedJson) {
    return Relation(
      childEntityName: parsedJson['ChildEntityName'],
      childReferenceColumnName: parsedJson['ChildReferenceColumnName'],
      referenceColumnName: parsedJson['ReferenceColumnName'],
    );
  }
  Map<dynamic, dynamic> toMap() {
    var map=new Map<String, dynamic>();
    map["ChildEntityName"]=childEntityName;
    map["ReferenceColumnName"]=referenceColumnName;
    map["ChildReferenceColumnName"]=childReferenceColumnName;
    return map;
  }
}


class MasterDataResponseModel {
  MasterDataDataModel masterDataDataModel;

  MasterDataResponseModel({this.masterDataDataModel});

  factory MasterDataResponseModel.fromJson(dynamic parsedJson) {
    return MasterDataResponseModel(
      masterDataDataModel: MasterDataDataModel.fromJson(parsedJson['data'])
    );
  }
}

class MasterDataDataModel {
  MasterDataModel masterDataModel;

  MasterDataDataModel({this.masterDataModel});

  factory MasterDataDataModel.fromJson(dynamic parsedJson) {
    return MasterDataDataModel(
      masterDataModel: MasterDataModel.fromJson(parsedJson['MASTERDATA'])
    );
  }
}

class MasterDataModel {
  Map<String,dynamic> masterData;

  MasterDataModel({this.masterData});

  factory MasterDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return MasterDataModel(
      masterData: parsedJson
    );
  }
}


class FormModel {
  int rows;
  int cols;
  String formId;
  String formLabel;

  FormModel({this.cols,this.formId,this.formLabel,this.rows});

  factory FormModel.fromJson(dynamic parsedJson) {
    return FormModel(
      rows: parsedJson['row'],
      cols: parsedJson['cols'],
      formId: parsedJson['fomrId'],
      formLabel: parsedJson['formLabel']
    );
  }
  Map<dynamic, dynamic> toMap() {
    var map=new Map<String, dynamic>();
    map["rows"]=rows;
    map["cols"]=cols;
    map["formId"]=formId;
    map["formLabel"]=formLabel;
    return map;
  }
}