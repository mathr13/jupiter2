import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
    isHeader = true;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
        children: buildRows(widget.data)
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
      listHeader.add(new TableRow(children: buildRowColumn(list)));
    }
    return listHeader;
  }

  List<Widget> buildRowColumn(dynamic list) {
    List<Widget> listHeader = new List<Widget>();
    for (int j = 0; j < widget.labelList.length; j++) {
      listHeader.add(new Column(children: <Widget>[
        new Container(
          child: new Text(
            isHeader == true ? widget.labelList[j]['label'].toString() : list[i-1][widget.labelList[j]['id'].toString()].toString(),
            style: new TextStyle(fontSize: 18),
          ),
        )
      ]));
    }
    return listHeader;
  }

}


