import 'package:flutter/material.dart';
import 'dart:async';
class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
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
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  dynamic response;
  DateTime selectedDate = DateTime.now();

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2020)
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        widget.formItems[widget.count]['value'] = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
        _handleChanged();

      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
       new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text("${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"
              ),
              new RaisedButton(onPressed: _selectDate, child: new Text('Click me'),)
            ],
          ),
        ),
      )
    ]
    ),
    );
  }
  void _handleChanged() {
    widget.onChanged(widget.formItems);
  }
}
