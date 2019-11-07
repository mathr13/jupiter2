import 'dart:convert';
String listingData = json.encode({


    "data": {
      "projectId": 11103,
      "DEFINITION": [
        {
          "templateId": "Listing Template",
          "nextSeq": 11,
          "definition": [
            {
              "id": "id",
              "label": "ID",
              "type": "label",
              "subType": "label",
              "regex": "",
              "constraint": "MANDATORY",
              "key": "S",
              "lov": "",
              "delim": "",
              "mapAttr": "",
              "dataSource": [
                {
                  "entityName": "Item",
                  "valueMember": "id",
                  "displayMember": "id",
                  "nodeHierarchy": "Item",
                  "sorting": [
                    {
                      "name": "asc",
                      "reverse": true
                    }
                  ],
                  "filters": []
                }
              ],
              "currentDate": false,
              "visibleInGrid": false,
              "visibleInFilter": false,
              "additionalSpecs": false,
              "qty": false,
              "copy": false,
              "dependentOn": "",
              "triggerCheck": "",
              "lovType": "S",
              "sort": 0,
              "entityName": "Item",
              "entityColName": "id",
              "nodeHierarchy": "Item",
              "defaultValue": ""
            },
//            {
//              "id": "catId",
//              "label": "ID",
//              "type": "label",
//              "subType": "label",
//              "regex": "",
//              "constraint": "MANDATORY",
//              "key": "S",
//              "lov": "",
//              "delim": "",
//              "mapAttr": "",
//              "dataSource": [
//                {
//                  "entityName": "Item",
//                  "valueMember": "id",
//                  "displayMember": "id",
//                  "nodeHierarchy": "Item",
//                  "sorting": [
//                    {
//                      "name": "asc",
//                      "reverse": true
//                    }
//                  ],
//                  "filters": []
//                }
//              ],
//              "currentDate": false,
//              "visibleInGrid": false,
//              "visibleInFilter": false,
//              "additionalSpecs": false,
//              "qty": false,
//              "copy": false,
//              "dependentOn": "",
//              "triggerCheck": "",
//              "lovType": "S",
//              "sort": 0,
//              "entityName": "Item",
//              "entityColName": "id",
//              "nodeHierarchy": "Item",
//              "defaultValue": ""
//            },
            {
              "id": "locId",
              "label": "LOCATION",
              "type": "label",
              "subType": "label",
              "constraint": "MANDATORY",
              "dataSource": [
                {
                  "entityName": "Item",
                  "valueMember": "locId",
                  "displayMember": "name",
                  "sorting": [
                    {
                      "name": "asc",
                      "reverse": true
                    }
                  ],
                  "filters": [],
                  "secondaryEntityName": "location",
                  "secondaryValueMember": "locId",
                  "secondaryDisplayMember": "name",
                  "nodeHierarchy": "Item"
                }
              ],
              "currentDate": false,
              "visibleInGrid": false,
              "visibleInFilter": false,
              "additionalSpecs": false,
              "sort": 0,
              "entityName": "Item",
              "entityColName": "locId",
              "nodeHierarchy": "Item",
              "defaultValue": ""
            }
          ],
          "cKeySeq": "t7",
          "scanner": "O",
          "docType": [],
          "qualification": false,
          "relevantQualification": [],
          "tag": false,
          "templateType": "Listing",
          "dataSource": [
            {
              "entityName": "Item",
              "valueMember": "id",
              "displayMember": "id",
              "sorting": [
                {
                  "name": "asc",
                  "reverse": true
                }
              ],
              "filters": []
            }
          ],
          "searchEnable": true,
          "searchAttributes": [
            "id",
            "locId"
          ],
          "searchPlaceholderLabel": "Search Item id. / location No."
        }
      ]
    },
    "status": {
      "messageList": [],
      "messageCode": 1200
    }
  });





