import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/forms/formRenderedElements.dart';
import 'package:jupiter/forms/formRendering.dart';
import 'package:jupiter/forms/validations.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'customButtons.dart';

class DropdownButtonHint extends StatefulWidget {
  const DropdownButtonHint(
      {this.onChanged, this.item, this.count, this.formItems, this.lovItems,this.color,this.isEditTrue,this.defaultValue});

  final int count;
  final Map item;
  final ValueChanged<dynamic> onChanged;
  final dynamic formItems;
  final lovItems;
  final Color color;
  final bool isEditTrue;
  final defaultValue;

  @override
  _DropdownButtonState createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtonHint> {
  String dropdownValue;

  void initState()
  {
    super.initState();
    dropdownValue=widget.isEditTrue==true?widget.defaultValue:dropdownValue;

  }
  @override
  Widget build(BuildContext context) {
    var db = new DatabaseHelper();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: widget.color,
//      width:(queryData.size.width)/2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new FutureBuilder(
              future: db.getTextFieldLabel(widget.item['label']),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (!snapshot.hasData) return addAsterisk(widget.item['label'],widget.item,context);
                return addAsterisk(snapshot.data.toString(),widget.item,context);
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
                          print(listOfHierarchy);

                          _handleChanged();
                      }
                      dropdownValue = newValue;
                      _handleChanged();
                    });
                  },
                  isExpanded: true,
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
