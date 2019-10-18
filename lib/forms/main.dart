
import 'package:flutter/material.dart';
import 'package:jupiter/forms/json_to_form.dart';
import 'dart:convert';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';


Object obj;
 String title="Form1";
 var res;
 List<Map> listOfHierarchy = [{}];
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
//  return WillPopScope(
//  onWillPop: () {
//    if(flag==true)
//      return Future.value(false);
//    else
//      return Future.value(true);
//
//  },
return  MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: App(),
//    onGenerateRoute: FluroRouter.router.generator,
    theme: ThemeData(
        primarySwatch: Colors.green
      ),
 // )
    );
  }
}
dynamic formValue;
class App extends StatefulWidget {
  App({
    this.formItems,
  });
  final dynamic formItems;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  void initState(){
    super.initState();
//     _getTemplateId();


//    var parsedFormData = json.decode(json.encode(formData));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
      primarySwatch: Colors.green
      ),
        home:Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {Navigator.pop(context);},
        // )

//    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp())))
// )
),
      body: new SingleChildScrollView(
        child: new Container(
          child: new Column(children: <Widget>[
            FutureBuilder<dynamic>(
                future: _getTemplateId(),
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return CoreForm(
                      form:formValue.toString(),
                       jsonForm: res[0]['template'],
                  )  ;
                }

            ),

//            new CoreForm(
//              form:formValue.toString(),
//              index: 0,
//              templateId:templateId ,
//              jsonForm: res,
//            ),
            new RaisedButton(
                child: new Text('Send'),
                onPressed: () async{
                 //  message();
//                print(result.toString());
//                print(responseDetails.toString());
                  _saveDataHierarchy();
                print(listOfHierarchy.toString());
//                   await getTemplate(id);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp(),maintainState: true));





                })
          ]),
        ),
      ),
      )
    );
  }

   _getTemplateId()async{
    var db = new DatabaseHelper();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id= sharedPreferences.get('TemplateID');
    res=  await db.fetchTemplateID(id);
//print(res[0]['template'].toString());

    return res[0]['template'].toString();

  }

_saveDataHierarchy()async{
  var db = new DatabaseHelper();
  var listHierarchy=json.decode(json.encode(listOfHierarchy[0]));
  listHierarchy.forEach((key,value)async
      {
        //print('keys '+key);
    if((key.split('.').length)==1)
      {
        print(value as Map<String,dynamic>);
       await db.populateTableWithMapping(key, value as Map<String,dynamic> , false);
       await db.populateTableWithCustomColumn(key.toUpperCase(), value as Map<String,dynamic>,'id', 12345,false);
      } else{
      var keysArray =  key.split('.');
      for(int i=0;i<keysArray.length;i++)
        {

         var parentTableName =  keysArray[(keysArray.length - 1)];
         var childTableName =  keysArray[(keysArray.length - 2)];
      //   var isParentTableExist =  await db.checkIfTableExist(parentTableName, false);
         //var isChildTableExist=  await db.checkIfTableExist(childTableName, false);
//         await db.checkIfTableExist(parentTableName, false).then((isParentTableExist)async{
//           if(isParentTableExist > 0) {
//             print(value as Map<String,dynamic>);
//             var isColumnExist = await db.isColumnExistInTable(parentTableName, childTableName);
//             if (isColumnExist.length > 0)
//             {
//               var valueJSON = (value as Map<String,dynamic>).toString();
//               print(valueJSON);
//             }
//           }
//         });
       await  db.checkIfTableExist(childTableName.toUpperCase(), false).then((isChildTableExist)async{
           if(isChildTableExist > 0)
           {
             //print(value as Map<String,dynamic>);
              await db.isColumnExistInTable(childTableName.toUpperCase(), parentTableName).then((isColumnExist)async{
                if (isColumnExist > 0)
                {
                  var valueJSON = (value as Map<String,dynamic>).toString();
                 // print(valueJSON);
                  await db.updateTableColumn(childTableName, json.encode(value), parentTableName, false);

                  //             await db.populateTableWithMapping(key, value as Map<String,dynamic> , false);
                }
              });

           }
         });

        }
    }
  });
//  for(int i=0;i<(savedData as Map).length;i++) {
//    var tableInfo = await db.fetchTablesData(false);
//    for (int j = 0; j < tableInfo.length; j++) {
//      if (tableInfo[i]['name'].contains(savedData[i].key) == true) {
//        var columnInfo = await db.fetchColumnData(tableInfo[i]['name']);
//        print(columnInfo);
//      }
//    }
//  }

}
  String message(){
    int i;
    String msg=' ';
    dynamic formItems=json.decode(json.encode(result));
    for( i=0;i<formItems.length;i++) {
      if (formItems[i]['type'] == 'text') {
        if (formItems[i]['response']== ""||formItems[i]['response']== null)
        {
          msg= msg + formItems[i]['id'] + ' cannot be empty \n';
          print(msg);
        }
      }
    }
    if(msg==" ")
      return msg;
    else {
       _showDialog(msg);
       return msg;
//  ShowAlert(message: msg,);
      // ShowAlert(message: msg,);
    }
  }
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error!"),
          content: new Text(message ,style:new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",style:new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
