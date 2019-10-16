import 'package:flutter/material.dart';
import 'package:jupiter/forms/Databasehelper.dart';
import 'package:jupiter/forms/json_to_form.dart';
class DropdownButtonHint extends StatefulWidget {
  const DropdownButtonHint({
    @required this.onChanged,
    this.item,
    this.count,
    this.formItems,
    this.lovItems
  });

  final int count;
  final Map item;
  final ValueChanged<dynamic> onChanged;
  final dynamic formItems;
  final lovItems;

  @override
  _DropdownButtonState createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtonHint> {
  String dropdownValue ;
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
                  return DropdownButton<dynamic>(
                    value:dropdownValue,
                  items: snapshot.data.toList()
                      .map(( dynamic value) => DropdownMenuItem<dynamic>(
                child: Text(value['displayName'].toString()),
                value: value['displayName'],
           ))
                        .toList(),
                    onChanged: ( newValue) {
                      setState(() {
                        int i;
                        for( i=0;i<widget.item['nodeHierarchy'].split('.').length;i++)
                        {
                          jsonData.putIfAbsent(
                              '${widget.item['nodeHierarchy'].split('.')[i]}',()=><String,dynamic>{}
                          );
                        }
                        jsonData['Item'].addAll({
                          '${widget.item['id']}':newValue
                        });
                        responseDetails.addAll({

                          "${widget.item['id']}":newValue
                        });
                        dropdownValue=newValue;
                        _handleChanged();
                      });
                    },
                    isExpanded: false,
                    hint: Text('Select'),
                  );
                }),

          ],
        ),
    );
  }
  void _handleChanged() {
    widget.onChanged(responseDetails);
  }
}
