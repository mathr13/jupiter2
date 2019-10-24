import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/forms/json_to_form.dart';
import 'package:jupiter/forms/main.dart';


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

  @override _DropdownButtonState createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtonHint> {
  String dropdownValue ;
  final db = new DatabaseHelper();


  @override Widget build(BuildContext context) {
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
                  return DropdownButton<dynamic>(
                    value:dropdownValue,
                  items: snapshot.data.toList()
                      .map(( dynamic value) => DropdownMenuItem<dynamic>(
                child: Text(value[widget.formItems[widget.count]['dataSource'][0]['displayMember']].toString()),
                value: value[widget.formItems[widget.count]['dataSource'][0]['valueMember']],
           ))
                        .toList(),
                    onChanged: ( newValue) {
                      setState(() {
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
                            '${widget.item['entityColName']}':newValue
                          });

                          _handleChanged();
                        }
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