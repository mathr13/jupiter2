import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';

class CustomLabel extends StatefulWidget {

final String text;
CustomLabel({this.text});



  @override
  _CustomState createState() => _CustomState();
}

class _CustomState extends State<CustomLabel> {


  @override Widget build(BuildContext context) {
    var db = DatabaseHelper();
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
//          FutureBuilder<String>(
//              future: db.getTextFieldLabel(widget.item['label']),
//              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                if (!snapshot.hasData) return new Text(addAsterisk(widget.item['label']), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
//                return new Text(addAsterisk(snapshot.data.toString()), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
//              }),
          new Text(widget.text

          )
        ],
      ),
    );
  }

}