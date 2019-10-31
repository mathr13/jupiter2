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
    return Text(widget.text,style: new TextStyle(fontSize: 18),

          );
  }

}