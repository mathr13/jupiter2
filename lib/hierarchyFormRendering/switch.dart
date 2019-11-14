import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {

final String text;
CustomSwitch({this.text});
  @override
  _CustomState createState() => _CustomState();

}



class _CustomState extends State<CustomSwitch> {
  String value;
  dynamic response;
  bool switchValue=false;



  @override
  Widget build(BuildContext context) {
    return new  Row(children: <Widget>[
      new Expanded(child: new Text(widget.text
      )),
      new Expanded(child:Switch(
          value: switchValue,
          onChanged: (bool value) {
            this.setState(() {
              switchValue=value;


            });
          }))
    ]);
  }


}

