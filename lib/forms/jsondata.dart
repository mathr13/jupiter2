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
              "id": "projectNumber",
              "label": "Project Number",
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
            {
              "id": "costCode",
              "label": "Cost Code",
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
            "costCode",
            "projectNumber"
          ],
          "searchPlaceholderLabel": "Search  Cost Code /  Project No"
        }
      ]
    },
    "status": {
      "messageList": [],
      "messageCode": 1200
    }
  });
String formData=json.encode(
{
"data": {
"FORM": [{
"formId": "fdf07735-6c31-4f49-a31f-ff86bb5e0259",
"formLabel": "Mobile",
"rows": 1.0,
"cols": 1.0,
"sections": [{
"docType": [],
"cKeySeq": "t7",
"sectionId": "98240c0d-8c4d-4305-a396-bba71bbacb2b",
"rows": 3.0,
"sections": [{
"colIndex": 1.0,
"rowIndex": 1.0,
"definition": [{
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
"sort": 0.0,
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
{
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
"sort": 0.0,
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
{
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
"sort": 0.0,
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
"key": "P",
"delim": "",
"visibleInFilter": false,
"triggerCheck": "",
"label": "af87d042-611b-4144-9710-edc31d0b6455",
"sort": 0.0,
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
{
"defaultValue": "",
"currentDate": false,
"type": "select",
"lov": "97add0d9-1a69-4aca-87d0-3b5e43765c4f",
"dependentOn": "",
"entityName": "Item",
"id": "t5",
"copy": false,
"lovType": "S",
"key": "",
"delim": "",
"visibleInFilter": false,
"triggerCheck": "",
"label": "11a5851d-f2c1-4ba5-9239-0fe672ccbe69",
"sort": 0.0,
"entityColName": "t5",
"regex": "",
"nodeHierarchy": "Item.attr",
"qty": false,
"subType": "select",
"constraint": "MANDATORY",
"mapAttr": "",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": [{
"nodeHierarchy": "",
"entityName": "lov",
"sorting": [{
"name": "asc",
"reverse": true
}],
"valueMember": "id",
"filters": [{
"value": "97add0d9-1a69-4aca-87d0-3b5e43765c4f",
"key": "domainGroup"
}],
"displayMember": "value"
}]
},
{
"defaultValue": "",
"currentDate": false,
"type": "radio",
"lov": "34fdde06-32c3-4778-bb0f-9cf0eec10a37",
"dependentOn": "",
"entityName": "Item",
"id": "t8",
"copy": false,
"lovType": "S",
"key": "",
"delim": "",
"visibleInFilter": false,
"triggerCheck": "",
"label": "a02a73cc-41ce-4c84-9d2d-7c1ff7e9ce13",
"sort": 0.0,
"entityColName": "t8",
"regex": "",
"nodeHierarchy": "Item.attr",
"qty": false,
"subType": "radio",
"constraint": "OPTIONAL",
"mapAttr": "",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": [{
"nodeHierarchy": "",
"entityName": "lov",
"sorting": [{
"name": "asc",
"reverse": true
}],
"valueMember": "id",
"filters": [{
"value": "34fdde06-32c3-4778-bb0f-9cf0eec10a37",
"key": "domainGroup"
}],
"displayMember": "value"
}]
},
{
"defaultValue": "",
"currentDate": false,
"type": "checkbox",
"lov": "8f035973-4cbd-4ceb-9630-6c3ef0ae172b",
"dependentOn": "",
"entityName": "Item",
"id": "t9",
"copy": false,
"lovType": "S",
"key": "",
"delim": "",
"visibleInFilter": false,
"triggerCheck": "",
"label": "ce9322e5-7e16-4e6e-89b9-8e3447b062e0",
"sort": 0.0,
"entityColName": "t9",
"regex": "",
"nodeHierarchy": "Item.attr",
"qty": false,
"subType": "checkbox",
"constraint": "OPTIONAL",
"mapAttr": "",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": [{
"nodeHierarchy": "",
"entityName": "lov",
"sorting": [{
"name": "asc",
"reverse": true
}],
"valueMember": "id",
"filters": [{
"value": "8f035973-4cbd-4ceb-9630-6c3ef0ae172b",
"key": "domainGroup"
}],
"displayMember": "value"
}]
},
{
"defaultValue": "",
"currentDate": false,
"type": "text",
"lov": "",
"dependentOn": "",
"entityName": "Item",
"id": "t10",
"copy": false,
"lovType": "",
"key": "",
"delim": "",
"visibleInFilter": false,
"triggerCheck": "",
"label": "9a1f4523-5245-4463-8a6c-28da4f37a36e",
"sort": 0.0,
"entityColName": "t10",
"regex": "^[0-9]*\$",
"nodeHierarchy": "Item.attr",
"qty": false,
"subType": "number",
"constraint": "OPTIONAL",
"mapAttr": "",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": []
},
{
"defaultValue": "",
"currentDate": false,
"type": "text",
"lov": "",
"dependentOn": "",
"entityName": "Item",
"id": "t11",
"copy": false,
"lovType": "S",
"key": "",
"delim": "",
"visibleInFilter": false,
"triggerCheck": "",
"label": "f9abc440-8eab-4bd7-8574-a8e054323848",
"sort": 1.0,
"entityColName": "t11",
"regex": "dd-MMM-yyyy",
"nodeHierarchy": "Item.attr",
"qty": false,
"subType": "date",
"constraint": "OPTIONAL",
"mapAttr": "",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": []
},
{
"visibleInFilter": false,
"defaultValue": "",
"currentDate": false,
"label": "LOCATION",
"sort": 0.0,
"type": "select",
"entityColName": "locId",
"nodeHierarchy": "Item",
"entityName": "Item",
"subType": "select",
"constraint": "MANDATORY",
"id": "locId",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": [{
"entityName": "location",
"sorting": [{
"name": "asc",
"reverse": true
}],
"valueMember": "locId",
"filters": [],
"displayMember": "name"
}]
},
{
"visibleInFilter": false,
"defaultValue": "",
"currentDate": false,
"label": "PURCHASE_PROJECT_NUMBER",
"sort": 0.0,
"type": "text",
"entityColName": "projectNumber",
"nodeHierarchy": "Item",
"entityName": "Item",
"subType": "text",
"constraint": "OPTIONAL",
"id": "projectNumber",
"visibleInGrid": false,
"additionalSpecs": false
},
{
"visibleInFilter": false,
"defaultValue": "",
"currentDate": false,
"label": "PURCHASE_COST_CENTER",
"sort": 0.0,
"type": "text",
"entityColName": "costCode",
"nodeHierarchy": "Item",
"entityName": "Item",
"subType": "text",
"constraint": "OPTIONAL",
"id": "costCode",
"visibleInGrid": false,
"additionalSpecs": false
},
{
"visibleInFilter": false,
"defaultValue": "",
"currentDate": false,
"label": "navigationContainer1",
"sort": 0.0,
"type": "navigationContainer",
"entityColName": "container1",
"nodeHierarchy": "Item",
"entityName": "Item",
"subType": "navigationContainer",
"constraint": "MANDATORY",
"id": "container1",
"visibleInGrid": false,
"additionalSpecs": false
},
{
"visibleInFilter": false,
"defaultValue": "##catId",
"currentDate": false,
"label": "catId",
"sort": 0.0,
"type": "hidden",
"entityColName": "catId",
"nodeHierarchy": "Item",
"entityName": "Item",
"subType": "hidden",
"constraint": "MANDATORY",
"id": "catId",
"visibleInGrid": false,
"additionalSpecs": false
},
{
"visibleInFilter": false,
"defaultValue": "##typeId",
"currentDate": false,
"label": "typeId",
"sort": 0.0,
"type": "hidden",
"entityColName": "typeId",
"nodeHierarchy": "Item",
"entityName": "Item",
"subType": "hidden",
"constraint": "MANDATORY",
"id": "typeId",
"visibleInGrid": false,
"additionalSpecs": false
}
]
},
{
"colIndex": 2.0,
"rowIndex": 2.0,
"definition": [{
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
"sort": 0.0,
"entityColName": "id",
"regex": "",
"nodeHierarchy": "Item",
"qty": false,
"subType": "label",
"constraint": "MANDATORY",
"mapAttr": "",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": [{
"nodeHierarchy": "Item",
"entityName": "Item",
"sorting": [{
"name": "asc",
"reverse": true
}],
"valueMember": "id",
"filters": [],
"displayMember": "id"
}]
},
{
"visibleInFilter": false,
"defaultValue": "",
"currentDate": false,
"label": "LOCATION",
"sort": 0.0,
"type": "label",
"entityColName": "locId",
"nodeHierarchy": "Item",
"entityName": "Item",
"subType": "label",
"constraint": "MANDATORY",
"id": "locId",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": [{
"secondaryValueMember": "locId",
"secondaryEntityName": "location",
"nodeHierarchy": "Item",
"secondaryDisplayMember": "name",
"entityName": "Item",
"sorting": [{
"name": "asc",
"reverse": true
}],
"valueMember": "locId",
"filters": [],
"displayMember": "name"
}]
}
]
}
],
"relevantQualification": [],
"qualification": false,
"scanner": "O",
"colIndex": 1.0,
"rowIndex": 1.0,
"nextSeq": 12.0,
"tag": false,
"cols": 2.0
}]
},
{
"formId": "fdf07735-6c31-4f49-a31f-ff86bb5e0260",
"formLabel": "ITEM_LISTING",
"rows": 1.0,
"cols": 1.0,
"sections": [{
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
"colIndex": 1.0,
"rowIndex": 1.0,
"definition": [{
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
"sort": 0.0,
"entityColName": "id",
"regex": "",
"nodeHierarchy": "Item",
"qty": false,
"subType": "label",
"constraint": "MANDATORY",
"mapAttr": "",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": [{
"nodeHierarchy": "Item",
"entityName": "Item",
"sorting": [{
"name": "asc",
"reverse": true
}],
"valueMember": "id",
"filters": [],
"displayMember": "id"
}]
},
{
"visibleInFilter": false,
"defaultValue": "",
"currentDate": false,
"label": "LOCATION",
"sort": 0.0,
"type": "label",
"entityColName": "locId",
"nodeHierarchy": "Item",
"entityName": "Item",
"subType": "label",
"constraint": "MANDATORY",
"id": "locId",
"visibleInGrid": false,
"additionalSpecs": false,
"dataSource": [{
"secondaryValueMember": "locId",
"secondaryEntityName": "location",
"nodeHierarchy": "Item",
"secondaryDisplayMember": "name",
"entityName": "Item",
"sorting": [{
"name": "asc",
"reverse": true
}],
"valueMember": "locId",
"filters": [],
"displayMember": "name"
}]
}
],
"tag": false,
"dataSource": [{
"entityName": "Item",
"sorting": [{
"name": "asc",
"reverse": true
}],
"valueMember": "id",
"filters": [],
"displayMember": "id"
}]
}]
}
],
"projectId": 11103
},
"status": {
"messageList": [],
"messageCode": 1200
}
});