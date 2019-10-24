import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/forms/json_to_form.dart';
import 'package:jupiter/forms/main.dart';
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
  String radioValue;
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
                child: new FutureBuilder(
                    future: db.getTextFieldLabel(widget.item['label']),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) return new Text(widget.item['label'], style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
                      return new Text(snapshot.data.toString(), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
                    }
                )
            ),
            FutureBuilder<List<dynamic>>(
                future: db.fetchDataSourceData(widget.formItems[widget.count]['dataSource']),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: column(snapshot.data)
                  );
                }
                  ),
    ]
    )
    );
                }

  List<Widget> column(dynamic list) {
    List<Widget> radioList=new List<Widget>();
    for (var i=0; i < list.length; i++) {
        radioList.add(new Row(children: <Widget>[
          new Expanded(
              child: new Text(
                  list[i][widget.formItems[widget.count]['dataSource'][0]['displayMember'].toString()].toString())),
          new Radio<String>(
              value: list[i][widget.formItems[widget.count]['dataSource'][0]['valueMember'].toString()],
              groupValue: radioValue,
              //int.parse(list[i]['displayValue']),
              onChanged: (String value) {
                this.setState(() {
                  radioValue = value;
                  {
                    if (listOfHierarchy.length==1) {
                      listOfHierarchy.first.putIfAbsent(
                          '${widget.item['nodeHierarchy']}',()=>[{}]
                      );
                    } else {
                      listOfHierarchy[listOfHierarchy.length].putIfAbsent(
                          '${widget.item['nodeHierarchy']}',()=>[{}]
                      );
                    }
                    listOfHierarchy[0]['${widget.item['nodeHierarchy']}'].first.addAll({
                      '${widget.item['entityColName']}':value
                    });
                  }
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