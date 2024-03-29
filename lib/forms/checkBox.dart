import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/forms/validations.dart';
import 'package:jupiter/Screens/Views/troy.dart';

// List<MaterialColor> abcd = [Colors.red,Colors.yellow,Colors.green,Colors.orange,Colors.pink,Colors.blue,Colors.brown,Colors.grey,Colors.green,Colors.black];

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

  @override _CustomState createState() => _CustomState();
}

class _CustomState extends State<CustomCheckBox> {
  List<bool> value;
  dynamic response;
  Map<String,bool> map ={};
  List<bool> booleans = [false];
  final db = new DatabaseHelper();

  @override Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child:Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new FutureBuilder(
              future: db.getTextFieldLabel(widget.item['label']),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (!snapshot.hasData) return addAsterisk(widget.item['label'],widget.item,context);
                return addAsterisk(snapshot.data.toString(),widget.item,context);
              }
            )
          ),
          FutureBuilder<List<dynamic>>(
            // future: db.fetchTablesData(false),
            future: db.fetchDataSourceData(widget.formItems[widget.count]['dataSource']),
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Container(
                child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: column(snapshot.data)
              ),
              );
            }
          ),
        ]
      ),
    );
  }

  List<Widget> column(dynamic list) {
    List<Widget> checkboxList = new List<Widget>();
    for(int i=0;i<list.length-1;i++) {booleans.add(false);}
    for(int i=0;i<list.length;i++) {
      // map.putIfAbsent(list[i][widget.formItems[widget.count]['dataSource'][0]['displayMember']],()=> false);
      checkboxList.add(new Row(
        children: <Widget>[
        new Expanded(
          child: new Text(list[i][widget.formItems[widget.count]['dataSource'][0]['displayMember']])
        ),
        new Checkbox(
          value:booleans[i],
          onChanged: (bool value) {
            this.setState(() {
              booleans[i] = value;
              // _handleChanged();
            });
          }
        )
      ]));
    }
    return checkboxList;
  }
  void _handleChanged() {
    widget.onChanged(widget.formItems);
  }
}