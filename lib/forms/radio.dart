import 'package:flutter/material.dart';
import 'package:jupiter/forms/Databasehelper.dart';
import 'package:jupiter/forms/json_to_form.dart';
class CustomRadio extends StatefulWidget {
  const CustomRadio({
    @required this.onChanged,
    this.item,
    this.count,
    this.formItems,
  });

  final int count;
  final Map item;
  final ValueChanged<dynamic> onChanged;
  final dynamic formItems;


  @override
  _CustomState createState() => _CustomState();

}



class _CustomState extends State<CustomRadio> {
  String value;
  int radioValue;
  final db = new DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
                margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: new Text(widget.item['label'],
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0))),
            FutureBuilder<List<dynamic>>(
                future: db.fetchTablesData(widget.formItems[widget.count]['lov']),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: column(snapshot.data));
                }
                  ),
    ]
    )
    );
                }

//            new Container(
//                margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
//                child: new Text(widget.item['label'],
//                    style: new TextStyle(
//                        fontWeight: FontWeight.bold, fontSize: 16.0))),
//            new Container(
//              child: Column(
//                  mainAxisSize: MainAxisSize.max,
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: column()),
//            ),
//          ]),
//    );
 // }

  List<Widget> column(dynamic list) {
    List<Widget> radioList=new List<Widget>();
    radioValue=widget.item['value'];
    for (var i=0; i < list.length; i++) {
        radioList.add(new Row(children: <Widget>[
          new Expanded(
              child: new Text(
                  list[i]['displayName'].toString())),
          new Radio<int>(
              value: int.parse(list[i]['displayValue']),
              groupValue: radioValue,
              onChanged: (int value) {
                this.setState(() {
                  radioValue = value;
                  responseDetails.addAll({

                    "${widget.item['id']}":value
                  });
                  widget.formItems[widget.count]['value'] = value;
                  _handleChanged();
                });
              })
        ]));
    }
    return radioList;
  }

  void _handleChanged() {
    widget.onChanged(responseDetails);
  }
}