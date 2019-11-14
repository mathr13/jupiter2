import 'package:flutter/material.dart';
import 'package:jupiter/List/listingViewElements.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'dart:core';
import 'dart:convert';
import 'package:jupiter/forms/jsondata.dart';

class ListingView extends StatefulWidget {
 String listData;
 dynamic value;
 String label;
  @override
  ListingViewState createState() => ListingViewState();
 ListingView({this.listData,this.value,this.label});

}

class ListingViewState extends State<ListingView> {
var labelList=[];
  var db = new DatabaseHelper();
  var searchController = new TextEditingController();
  String _query = "";
  TextEditingController emailController = new TextEditingController();
var listingDataDecoded;


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
     listingDataDecoded = json.decode(widget.listData);
    labelList = listingDataDecoded['sections'][0]['definition'][0]['definition'];
var isSearchEnable =listingDataDecoded['sections'][0]['definition'][0]['searchEnable'];
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: new Container(
       margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: new Column(
          children: <Widget>[
            isSearchEnable==true?_createSearchView():Container(),
            new Expanded(
              child: _createListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createSearchView() {

    return new Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child:Container(
          height:40,
          decoration: BoxDecoration(border: Border.all(width: 1.0)),
          child: new Center(child:TextField(
            controller: searchController,
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              hintText: listingDataDecoded['sections'][0]['definition'][0]['searchPlaceholderLabel'],
              hintStyle: new TextStyle(color: Colors.grey[300]),
            ),
            //textAlign: TextAlign.center,
          ),
          )
      )
    );
  }

  Widget _createListView() {
    return FutureBuilder<List<dynamic>>(
      future: widget.label=="INVENTORY"?
      db.getListingResults("ITEM", _query,listingDataDecoded['sections'][0]['definition'][0]['searchAttributes']):

        db.getItemListingResults("ITEMTYPE", null, null, null,widget.value),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        var data = snapshot.data;
        return snapshot.hasData
            ? widget.label=="INVENTORY"? ListingViewElements(data,labelList,true,widget.label):ListingViewElements(data,labelList,false,"ITEMTYPE")
            : new Center(child: new CircularProgressIndicator());
      },
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:jupiter/List/listingViewElements.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'dart:core';
import 'dart:convert';
import 'package:jupiter/forms/jsondata.dart';

class ListingView extends StatefulWidget {
 String listData;
  @override
  ListingViewState createState() => ListingViewState();
 ListingView({this.listData});

}

class ListingViewState extends State<ListingView> {
var labelList=[];
  var db = new DatabaseHelper();
  var searchController = new TextEditingController();
  String _query = "";
  TextEditingController emailController = new TextEditingController();
var listingDataDecoded;


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
     listingDataDecoded = json.decode(widget.listData);
    labelList = listingDataDecoded['data']['definition'][0]['definition'];
var isSearchEnable =listingDataDecoded['data']['defination'][0]['searchEnable'];
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: new Container(
       margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: new Column(
          children: <Widget>[
            isSearchEnable==true?_createSearchView():Container(),
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
        height:40,
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new Center(child:TextField(
        controller: searchController,
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: listingDataDecoded['data']['definition'][0]['searchPlaceholderLabel'],
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        //textAlign: TextAlign.center,
      ),
      )
    );
  }

  Widget _createListView() {
    return FutureBuilder<List<dynamic>>(
      future: db.getListingResults("ITEM", _query,listingDataDecoded['data']['definition'][0]['searchAttributes']),
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

*/