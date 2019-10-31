import 'package:flutter/material.dart';
import 'package:jupiter/forms/formRenderedElements.dart';
class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
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



class _CustomState extends State<CustomSwitch> {
  String value;
  dynamic response;



  @override
  Widget build(BuildContext context) {
    return new  Row(children: <Widget>[
      new Expanded(child: new Text(widget.item['label'])),
      new Switch(
          value: widget.item['switchValue'],
          onChanged: (bool value) {
            this.setState(() {
              responseDetails.addAll({

                "${widget.item['id']}":value
              });

              widget.formItems[widget.count]['switchValue'] = value;
              _handleChanged();
            });
          })
    ]);
  }

  void _handleChanged() {
   widget.onChanged(responseDetails);
  }
}

