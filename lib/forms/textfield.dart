import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jupiter/Constant/string_constant.dart';
import 'package:jupiter/forms/json_to_form.dart';

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
    widget.formItems[widget.count]['response'] = null;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
              padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: new Text(addAsterisk(),
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              )),
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
<<<<<<< HEAD:lib/forms/textfield.dart
=======

//              print(widget.item['nodehierarchy'].split('.').length);
//              print(widget.item['nodehierarchy'].split('.').join('\'][\''));
//print('[\''+widget.item['nodehierarchy'].split('.').join('\'][\'')+'\']');
//jsonData.addAll({
//
//
//});
>>>>>>> 50f12c841a030f948b8c3ad55367631a252bec26:lib/forms/textfield.dart
              responseDetails.addAll({

                "${widget.item['id']}":value
              });
//              widget.formItems[widget.count]['response'] = value;
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
  String addAsterisk(){
    if(widget.item['constraint']=='MANDATORY')
      return '*'+widget.item['label'];
    else
      return widget.item['label'];

  }

}
