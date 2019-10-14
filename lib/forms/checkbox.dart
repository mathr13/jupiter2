import 'package:flutter/material.dart';
import 'package:jupiter/forms/Databasehelper.dart';
class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
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

class _CustomState extends State<CustomCheckBox> {
 List<bool> value;
  dynamic response;
  Map<String,bool> map ={};
  final db = new DatabaseHelper();



  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
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
      ),
    );
  }
  List<Widget> column(dynamic list) {
    List<Widget> checkboxList = new List<Widget>();
    for (var i = 0; i < list.length; i++) {
      map.putIfAbsent(list[i]['displayName'],()=> false);
//      value= list[i]['value']==0?false:true;
      checkboxList.add(new Row(children: <Widget>[
          new Expanded(
              child: new Text(list[i]['displayName'])),
          new Checkbox(
              value:map.values.toList()[i],
              onChanged: (bool value) {
                this.setState(() {
                  print(i);
                  map[list[i]['diaplayName']]=value;
                  print(map.values.toList()[i]);

                  _handleChanged();
                });
              })
        ]));
    }
    return checkboxList;

  }
  void _handleChanged() {
    widget.onChanged(widget.formItems);
  }
}




