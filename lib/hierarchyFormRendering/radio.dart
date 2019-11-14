import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';

class CustomRadio extends StatefulWidget {

  @override
  _CustomState createState() => _CustomState();

}



class _CustomState extends State<CustomRadio> {
  String value;
  String radioValue;
  final db = new DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
//      width: queryData.size.width/3,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
                margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
                child:Text("gdg")

                ),

    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: column()
    )
    ]
    )
    );
                }

  List<Widget> column() {
    List<Widget> radioList=new List<Widget>();
    for (var i=0; i <4; i++) {
        radioList.add(new Row(children: <Widget>[
          new Expanded(
              child: new Text(
                "a"
              )),
          new Radio<String>(
              value: "a",
              groupValue: radioValue,
              //int.parse(list[i]['displayValue']),
              onChanged: (String value) {
                this.setState(() {
                  radioValue = value;
                  _handleChanged();
                });
              })
        ]));
    }
    return radioList;
  }

  void _handleChanged() {
  }
}