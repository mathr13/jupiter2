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
      template: parsedJson['template'].toString()
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
  String precision;
  String scale;
  String maxLength;

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