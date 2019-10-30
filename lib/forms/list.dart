//import 'package:flutter/material.dart';
//import 'package:jupiter/Databasehelper/databaseHelper.dart';
//import 'jsondata.dart';
//import 'dart:convert';
//import 'package:jupiter/Components/singleLabel.dart';
//
//class CustomList extends StatefulWidget {
//  int data = 9;
//var labelList= [];
//  @override
//  _CustomListState createState() => _CustomListState();
//}
//
//class _CustomListState extends State<CustomList> {
//  final db = new DatabaseHelper();
//  final listingDataDecoded = json.decode(listingData);
//
//  @override
//  Widget build(BuildContext context) {
//    widget.labelList = listingDataDecoded['data']['DEFINITION'][0]['template'][0]
//        ['definition'];
//    for (int i = 0; i <  widget.labelList.length; i++) {
//      print( widget.labelList[i]['label']);
//    }
//    return Scaffold(
//        appBar: new AppBar(),
////        body: Column(
////          children: <Widget>[
////            Row(
////                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////                children: row(labelList)
////            ),
////
////
////
////          FutureBuilder<List<dynamic>>(
////              future: db.fetchListingData('ITEM'),
////              builder: (BuildContext context,
////                  AsyncSnapshot<List<dynamic>> snapshot) {
////                if (!snapshot.hasData) return CircularProgressIndicator();
////                return Row(
////                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////                    children: listTileRow(snapshot.data)
////                );
////              }
////          ),
////        ])
//    body: Column(
//      children:[ Table(
//      border: null,
//      children: [
//        TableRow(
//          children:
//            row(widget.labelList),
//    )]
//        ),
//        Table(
//          border : null,
//children: [
//            TableRow(
//    children:[
//            FutureBuilder<List<dynamic>>(
//              future: db.fetchListingData('ITEM'),
//              builder: (BuildContext context,
//                  AsyncSnapshot<List<dynamic>> snapshot) {
//                if (!snapshot.hasData) return CircularProgressIndicator();
//                return Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: listTileRow(snapshot.data)
//                );
//              }
//        )
//      ]
//    ),
//    ]
//        )
//        ]
//    )
//
//    );
//  }
//
//  List<Widget> row(dynamic list) {
//    List<Widget> listHeader = new List<Widget>();
//    for (var i = 0; i < list.length; i++) {
//      listHeader.add(new Column(children: <Widget>[
//        new Container(
//          child: new Text(
//            list[i]['label'],
//            style: new TextStyle(fontSize: 18),
//          ),
//        )
//      ]));
//    }
//    return listHeader;
//  }
//}
//List<Widget> listTileRow(dynamic list) {
//  List<Widget> listHeader = new List<Widget>();
//  for (int j = 0; j < 4; j++) {
//    for (var i = 0; i < 2; i++) {
//      listHeader.add(new Column(children: <Widget>[
//        new Container(
//          child: new Text(
//            " adff",
//            style: new TextStyle(fontSize: 10),
//          ),
//        )
//      ]));
//    }
//    return listHeader;
//  }
//}
//
///*
//Row(
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: row(labelList)
//      )
// */
