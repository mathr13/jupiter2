import 'package:flutter/material.dart';
import 'package:jupiter/List/listingViewElements.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'dart:core';
import 'dart:convert';
import 'package:jupiter/forms/jsondata.dart';

class ListingView extends StatefulWidget {

  @override
  ListingViewState createState() => ListingViewState();
}

class ListingViewState extends State<ListingView> {
var labelList=[];
  var db = new DatabaseHelper();
  var searchController = new TextEditingController();
  String _query = "";
  TextEditingController emailController = new TextEditingController();
  final listingDataDecoded = json.decode(listingData);



  @override
  void initState() {
    super.initState();
  }

  ListingViewState() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          _query = "";
        });
      } else {
        setState(() {
          _query = searchController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    labelList = listingDataDecoded['data']['DEFINITION'][0]['definition'];
var searchEnable =listingDataDecoded['data']['DEFINITION'][0]['searchEnable'];
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: new Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: new Column(
          children: <Widget>[
            searchEnable==true?_createSearchView():Container(),
            new Expanded(
              child: _createListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {
    return new Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: searchController,
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: listingDataDecoded['data']['DEFINITION'][0]['searchPlaceholderLabel'],
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        //textAlign: TextAlign.center,
      ),
    );
  }

  Widget _createListView() {
    return FutureBuilder<List<dynamic>>(
      future: db.getListingResults("ITEM", _query,listingDataDecoded['data']['DEFINITION'][0]['searchAttributes']),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        var data = snapshot.data;
        return snapshot.hasData
            ? ListingViewElements(data,labelList)
            : new Center(child: new CircularProgressIndicator());
      },
    );
  }
}

