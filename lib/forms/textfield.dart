import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jupiter/forms/json_to_form.dart';
import 'package:jupiter/forms/main.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';

class CustomText extends StatefulWidget {
   CustomText({
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

class _CustomState extends State<CustomText> {
  String value;
  var obj;

  @override
  Widget build(BuildContext context) {
    var db =DatabaseHelper();
    widget.formItems[widget.count]['response'] = null;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FutureBuilder<String>(
            // future: db.getTextFieldLabel(widget.item['label']),
        builder: (BuildContext context,
            AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) return new Text(addAsterisk(widget.item['label']),
            style:
            new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),

          );
          return new Text(addAsterisk(snapshot.data.toString()),
              style:
                   new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),


          );
        }),
          (new TextField(
            controller: null,
            decoration: new InputDecoration(
              hintText: widget.item['id'] ?? "",
            ),
//            maxLines: widget.item['type'] == "text" ? 10 : 1,
            keyboardType: selectType(),
            //       inputFormatters: [WhitelistingTextInputFormatter(RegExp(widget.menus['regex'])),],
            inputFormatters: <TextInputFormatter>[
//              WhitelistingTextInputFormatter(RegExp(widget.item['regex'])),
//              BlacklistingTextInputFormatter(RegExp(widget.item['regex'])),

              BlacklistingTextInputFormatter.singleLineFormatter,
            ],
            onChanged: (String value) {
              if (listOfHierarchy.length==1) {
                listOfHierarchy.first.putIfAbsent(
                  '${widget.item['nodeHierarchy']}',()=>{}
                );
              } else {
                listOfHierarchy[listOfHierarchy.length].putIfAbsent(
                  '${widget.item['nodeHierarchy']}',()=>{}
                );
              }
              listOfHierarchy[0]['${widget.item['nodeHierarchy']}'].addAll({
                '${widget.item['entityColName']}':value
              });
              _handleChanged();
            },
            obscureText: widget.item['type'] == "Password" ? true : false,
          )),
        ],
      ),
    );
  }

  void _handleChanged() {
    widget.onChanged(responseDetails);
  }
  TextInputType selectType (){
    if(widget.item['subType']=='text')
      return TextInputType.text;
    else if(widget.item['subType']=='number')
      return TextInputType.number;
    else if(widget.item['subType']=='decimal')
      return TextInputType.phone;
    else return TextInputType.text;
  }
  String addAsterisk(String textFieldName ){
    if(widget.item['constraint']=='MANDATORY')
      return '*'+textFieldName;
    else
      return textFieldName;

  }

}
