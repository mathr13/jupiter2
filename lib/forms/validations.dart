import 'package:flutter/material.dart';
RichText addAsterisk(String textFieldName,Map item,BuildContext context) {
  if(item['constraint']=='MANDATORY')
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: '*',  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0,color: Colors.red)),
          TextSpan(text:textFieldName, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        ],
      ),
    );
  else if(item['constraint']=='REQUIRED')
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: '*',  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Colors.green)),
          TextSpan(text:textFieldName, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        ],
      ),
    );
  else if(item['constraint']=='OPTIONAL')
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: '*',  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Colors.grey)),
          TextSpan(text:textFieldName, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        ],
      ),
    );
  else return RichText(
        text: TextSpan(
            text: textFieldName,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)
        )); ;
}
