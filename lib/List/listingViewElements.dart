import 'package:flutter/material.dart';
import 'package:jupiter/Components/singleLabel.dart';
import 'dart:core';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
bool isHeader;

class ListingViewElements extends StatefulWidget {
  List<dynamic> data;
  List labelList;

  ListingViewElements  (
      this.data,this.labelList);
  @override
  ListingViewElementsState createState() => ListingViewElementsState();
}

class ListingViewElementsState extends State<ListingViewElements> {
  var db = new DatabaseHelper();

  void initState() {
    super.initState();
    isHeader = true;
  }

  @override
  Widget build(BuildContext context) {
   return SingleChildScrollView(
        scrollDirection: Axis.vertical,
       child: Table(
        children: buildRows(widget.data)
    )
    );
  }
  int i;

  List<TableRow> buildRows(dynamic list) {
    List<TableRow> listHeader = new List<TableRow>();

    for (i = 0; i < list.length + 1; i++) {
      if (i == 0)
        isHeader = true;
      else
        isHeader = false;
      listHeader.add(new TableRow(children: buildRowColumn(list),decoration:
      new BoxDecoration(
        border:Border(bottom: BorderSide(width:10.0,color:Colors.transparent),
            top: BorderSide(width:10.0,color:Colors.transparent))

      )
      ));
    }
    return listHeader;
  }

  List<Widget> buildRowColumn(dynamic list) {
    List<Widget> listHeader = new List<Widget>();
    for (int j = 0; j < widget.labelList.length; j++) {
      listHeader.add(new Column(children: <Widget>[
        new Container(
            child:isHeader==true?(new Text(widget.labelList[j]['label'].toString(), style: new TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0,letterSpacing:3)
            )):
    (widget.labelList[j]['dataSource'][0]['secondaryEntityName']!=null?
    (new FutureBuilder(
                future: db.getListingLabel(widget.labelList[j]['dataSource'][0]['secondaryEntityName'].toUpperCase(),widget.labelList[j]['dataSource'][0]['secondaryValueMember'],list[i-1][widget.labelList[j]['id'].toString()].toString(),widget.labelList[j]['dataSource'][0]['secondaryDisplayMember']),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) return  CircularProgressIndicator();
//                  Text(list[i-1][widget.labelList[j]['id'].toString()].toString(), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
                  return new Text(snapshot.data.toString(), style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0));
                }
            )):
           new Text(list[i-1][widget.labelList[j]['id'].toString()].toString(), style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)
          )
        )
        )
      ]));
    }
    return listHeader;
  }

}


