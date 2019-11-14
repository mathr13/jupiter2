import 'dart:convert';
String listingData = json.encode(
    {
      "data": {
        "FORM": [
          {
            "formId": "98240c0d-8c4d-4305-a396-bba71bbacb2b",
            "formLabel": "Mobile",
            "rows": 1,
            "cols": 1,
            "sections": [
              {
                "qualification": false,
                "docType": [],
                "cKeySeq": "t7",
                "scanner": "O",
                "colIndex": 1,
                "rowIndex": 1,
                "nextSeq": 12,
                "tag": false,
                "rows": 5,
                "cols": 5,
                "sections": [
                  {
                    "colIndex": 0,
                    "rowIndex": 0,
                    "definition": [
                      {
                        "defaultValue": "",
                        "currentDate": false,
                        "type": "text",
                        "lov": "",
                        "dependentOn": "",
                        "entityName": "Item",
                        "id": "t2",
                        "copy": false,
                        "lovType": "S",
                        "key": "S",
                        "delim": "",
                        "visibleInFilter": false,
                        "triggerCheck": "",
                        "label": "a3e80999-e85a-4eab-9076-facbff5a227d",
                        "sort": 0,
                        "entityColName": "t2",
                        "regex": "",
                        "nodeHierarchy": "Item.specAttr",
                        "qty": false,
                        "subType": "text",
                        "constraint": "MANDATORY",
                        "mapAttr": "",
                        "visibleInGrid": false,
                        "additionalSpecs": false,
                        "dataSource": []
                      },

                    ]
                  },
                  {
                    "colIndex": 1,
                    "rowIndex": 2,
                    "definition": [
                      {
                        "defaultValue": "",
                        "currentDate": false,
                        "type": "text",
                        "lov": "",
                        "dependentOn": "",
                        "entityName": "Item",
                        "id": "t7",
                        "copy": false,
                        "lovType": "S",
                        "key": "S",
                        "delim": "",
                        "visibleInFilter": false,
                        "triggerCheck": "",
                        "label": "a3e80999-e85a-4eab-9076-facbff5a227d",
                        "sort": 0,
                        "entityColName": "t2",
                        "regex": "",
                        "nodeHierarchy": "Item.specAttr",
                        "qty": false,
                        "subType": "text",
                        "constraint": "MANDATORY",
                        "mapAttr": "",
                        "visibleInGrid": false,
                        "additionalSpecs": false,
                        "dataSource": []
                      },

                    ]
                  },
                  {
                    "colIndex": 2,
                    "rowIndex": 2,
                    "definition": [{
                      "defaultValue": "",
                      "currentDate": false,
                      "type": "text",
                      "lov": "",
                      "dependentOn": "",
                      "entityName": "Item",
                      "id": "t4",
                      "copy": false,
                      "lovType": "S",
                      "key": "S",
                      "delim": "",
                      "visibleInFilter": false,
                      "triggerCheck": "",
                      "label": "85acf928-f1c3-41dc-b2ca-7730524e59dc",
                      "sort": 0,
                      "entityColName": "t4",
                      "regex": "^[0-9]*\$",
                      "nodeHierarchy": "Item.specAttr",
                      "qty": false,
                      "subType": "number",
                      "constraint": "MANDATORY",
                      "mapAttr": "",
                      "visibleInGrid": false,
                      "additionalSpecs": false,
                      "dataSource": []
                    },

                    ]
                  },
                  {
                    "colIndex": 3,
                    "rowIndex": 3,
                    "definition": [{
                      "defaultValue": "",
                      "currentDate": false,
                      "type": "text",
                      "lov": "",
                      "dependentOn": "",
                      "entityName": "Item",
                      "id": "autoid",
                      "copy": false,
                      "lovType": "",
                      "key": "",
                      "delim": "",
                      "visibleInFilter": false,
                      "triggerCheck": "",
                      "label": "ff78e678-ccda-4e26-be80-11eef24477be",
                      "sort": 0,
                      "entityColName": "autoid",
                      "regex": "",
                      "nodeHierarchy": "Item.attr",
                      "qty": false,
                      "subType": "autoId",
                      "constraint": "OPTIONAL",
                      "mapAttr": "",
                      "visibleInGrid": false,
                      "additionalSpecs": false,
                      "dataSource": []
                    },

                    ]
                  },
                  {
                    "colIndex": 4,
                    "rowIndex": 4,
                    "definition": [{
                      "defaultValue": "",
                      "currentDate": false,
                      "type": "text",
                      "lov": "",
                      "dependentOn": "",
                      "entityName": "Item",
                      "id": "t7",
                      "copy": false,
                      "lovType": "S",
                      "key": "P",
                      "delim": "",
                      "visibleInFilter": false,
                      "triggerCheck": "",
                      "label": "af87d042-611b-4144-9710-edc31d0b6455",
                      "sort": 0,
                      "entityColName": "t7",
                      "regex": "",
                      "nodeHierarchy": "Item.attr",
                      "qty": false,
                      "subType": "text",
                      "constraint": "MANDATORY",
                      "mapAttr": "",
                      "visibleInGrid": false,
                      "additionalSpecs": false,
                      "dataSource": []
                    },

                    ]
                  },
                  {
                    "colIndex": 5,
                    "rowIndex": 5,
                    "definition": [

                    ]
                  },
                  {
                    "colIndex": 6,
                    "rowIndex": 6,
                    "definition": [

                    ]
                  }, {
                    "colIndex": 7,
                    "rowIndex": 7,
                    "definition": [

                    ]
                  }, {
                    "colIndex": 8,
                    "rowIndex": 8,
                    "definition": [

                    ]
                  }, {
                    "colIndex": 9,
                    "rowIndex": 9,
                    "definition": [

                    ]
                  },
                ],
                "relevantQualification": []
              }
            ]
          },
          {
            "formId": "fdf07735-6c31-4f49-a31f-ff86bb5e0260",
            "formLabel": "ITEM_LISTING",
            "rows": 1,
            "cols": 1,
            "sections": [
              {
                "templateType": "Listing",
                "searchEnable": true,
                "searchPlaceholderLabel": "Search Item id. / location No.",
                "docType": [],
                "cKeySeq": "t7",
                "searchAttributes": [
                  "id",
                  "locId"
                ],
                "relevantQualification": [],
                "qualification": false,
                "scanner": "O",
                "colIndex": 1,
                "rowIndex": 1,
                "definition": [
                  {
                    "defaultValue": "",
                    "currentDate": false,
                    "type": "label",
                    "lov": "",
                    "dependentOn": "",
                    "entityName": "Item",
                    "id": "id",
                    "copy": false,
                    "lovType": "S",
                    "key": "S",
                    "delim": "",
                    "visibleInFilter": false,
                    "triggerCheck": "",
                    "label": "ID",
                    "sort": 0,
                    "entityColName": "id",
                    "regex": "",
                    "nodeHierarchy": "Item",
                    "qty": false,
                    "subType": "label",
                    "constraint": "MANDATORY",
                    "mapAttr": "",
                    "visibleInGrid": false,
                    "additionalSpecs": false,
                    "dataSource": [
                      {
                        "nodeHierarchy": "Item",
                        "entityName": "Item",
                        "sorting": [
                          {
                            "name": "asc",
                            "reverse": true
                          }
                        ],
                        "valueMember": "id",
                        "filters": [],
                        "displayMember": "id"
                      }
                    ]
                  },
                  {
                    "visibleInFilter": false,
                    "defaultValue": "",
                    "currentDate": false,
                    "label": "LOCATION",
                    "sort": 0,
                    "type": "label",
                    "entityColName": "locId",
                    "nodeHierarchy": "Item",
                    "entityName": "Item",
                    "subType": "label",
                    "constraint": "MANDATORY",
                    "id": "locId",
                    "visibleInGrid": false,
                    "additionalSpecs": false,
                    "dataSource": [
                      {
                        "secondaryValueMember": "locId",
                        "secondaryEntityName": "location",
                        "nodeHierarchy": "Item",
                        "secondaryDisplayMember": "name",
                        "entityName": "Item",
                        "sorting": [
                          {
                            "name": "asc",
                            "reverse": true
                          }
                        ],
                        "valueMember": "locId",
                        "filters": [],
                        "displayMember": "name"
                      }
                    ]
                  }
                ],
                "tag": false,
                "dataSource": [
                  {
                    "entityName": "Item",
                    "sorting": [
                      {
                        "name": "asc",
                        "reverse": true
                      }
                    ],
                    "valueMember": "id",
                    "filters": [],
                    "displayMember": "id"
                  }
                ]
              }
            ]
          }
        ],
        "projectId": 11103
      },
      "status": {
        "messageList": [],
        "messageCode": 1200
      }
    }
);
String listing = json.encode(

{
"data": {
"projectId": 11103, "definition": [
{
"templateId": "Listing Template", "nextSeq": 11, "definition": [
{
"id": "id", "label": "PROJECT NUMBER", "type": "label", "subType": "label", "regex": "", "constraint": "MANDATORY", "key": "S", "lov": "", "delim": "", "mapAttr": "", "dataSource": [
{
"entityName": "Item", "valueMember": "id", "displayMember": "id", "nodeHierarchy": "Item", "sorting": [
{
"name": "asc", "reverse": true } ], "filters": [] } ], "currentDate": false, "visibleInGrid": false, "visibleInFilter": false, "additionalSpecs": false, "qty": false, "copy": false, "dependentOn": "", "triggerCheck": "", "lovType": "S", "sort": 0, "entityName": "Item", "entityColName": "id", "nodeHierarchy": "Item", "defaultValue": "" }, {
"id": "locId", "label": "LOCATION", "type": "label", "subType": "label", "constraint": "MANDATORY", "dataSource": [
{
"entityName": "Item", "valueMember": "locId", "displayMember": "name",
"sorting": [
{
"name": "asc", "reverse": true } ], "filters": [], "secondaryEntityName": "location", "secondaryValueMember": "locId", "secondaryDisplayMember": "name", "nodeHierarchy": "Item" } ], "currentDate": false, "visibleInGrid": false, "visibleInFilter": false, "additionalSpecs": false, "sort": 0, "entityName": "Item", "entityColName": "locId", "nodeHierarchy": "Item", "defaultValue": "" } ], "cKeySeq": "t7", "scanner": "O", "docType": [], "qualification": false, "relevantQualification": [], "tag": false, "templateType": "Listing", "dataSource": [
{
"entityName": "Item", "valueMember": "id", "displayMember": "id", "sorting": [
{
"name": "asc", "reverse": true } ], "filters": [] } ], "searchEnable": true, "searchAttributes": [
"projectNumber", "locId" ], "searchPlaceholderLabel": "Project Number id. / location No." } ] }, "status": {
"messageList": [], "messageCode": 1200 } } );
