import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:jupiter/forms/formRendering.dart';

var db =DatabaseHelper();
String defaultV;

class CustomHidden extends StatefulWidget {
   CustomHidden({
    @required this.onChanged,
    this.item,
    this.count,
    this.formItems,
    this.defaultValue
  });

  final int count;
  final Map item;
  final ValueChanged<dynamic> onChanged;
  final dynamic formItems;
  String defaultValue;

  @override
  _CustomState createState() => _CustomState();
}

class _CustomState extends State<CustomHidden> {
  String value;
  var obj;

  @override
  void initState(){
    super.initState();
    _getHiddenData();


  }
_getHiddenData() async{
    var db = await DatabaseHelper();
    db.fetchLabelFromGV(widget.defaultValue.split("##")[1]).then((value){
      if (listOfHierarchy.length==1) {
        listOfHierarchy.first.putIfAbsent('${widget.item['nodeHierarchy']}',()=>[{}]);
      } else {
        listOfHierarchy[listOfHierarchy.length].putIfAbsent('${widget.item['nodeHierarchy']}',()=>[{}]);
      }
      listOfHierarchy[0]['${widget.item['nodeHierarchy']}'].first.addAll({'${widget.item['entityColName']}':value});
    });

}
  Widget build(BuildContext context) {
    // db.fetchLabelFromGV(widget.defaultValue.split("##")[1]).then((res) {
    //   // widget.defaultValue = res[0]['key'];
    //   defaultV = res[0]['value'];
    // });
    widget.formItems[widget.count]['response'] = null;
   return Container();
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text((widget.item['label']), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
          FutureBuilder<String>(
            future: db.fetchLabelFromGV(widget.defaultValue.split("##")[1]),
            builder: (BuildContext context,
                AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return new Text((snapshot.data.toString()), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
              }
              else {
                return new Text((" "), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
              }
            }
          ),
        ],
      ),
    );
  }
}


