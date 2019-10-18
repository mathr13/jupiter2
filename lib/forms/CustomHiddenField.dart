import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jupiter/forms/json_to_form.dart';
import 'package:jupiter/forms/main.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';

var db =DatabaseHelper();
String defaultV;

class CustomHidden extends StatefulWidget {
   CustomHidden({
    @required this.onChanged,
    this.item,
    this.count,
    this.formItems,
    this.defaultValue
  });

  final int count;
  final Map item;
  final ValueChanged<dynamic> onChanged;
  final dynamic formItems;
  String defaultValue;

  @override
  _CustomState createState() => _CustomState();
}

class _CustomState extends State<CustomHidden> {
  String value;
  var obj;

  @override Widget build(BuildContext context) {
    // db.fetchLabelFromGV(widget.defaultValue.split("##")[1]).then((res) {
    //   // widget.defaultValue = res[0]['key'];
    //   defaultV = res[0]['value'];
    // });

    widget.formItems[widget.count]['response'] = null;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text((widget.item['label']),
              style:
                   new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),


          ),
          FutureBuilder<String>(
           future: db.fetchLabelFromGV(widget.defaultValue.split("##")[1]),
        builder: (BuildContext context,
            AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) 
         return new Text((snapshot.data.toString()),
              style:
                   new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),


          );
          
        }),
          (new Text(defaultV ?? "")),
        ],
      ),
    );
  }

  void _handleChanged() {
    widget.onChanged(responseDetails);
  }
  TextInputType selectType (){
    if(widget.item['subType']=='text')
      return TextInputType.text;
    else if(widget.item['subType']=='number')
      return TextInputType.number;
    else if(widget.item['subType']=='decimal')
      return TextInputType.phone;
    else return TextInputType.text;
  }
  
}

