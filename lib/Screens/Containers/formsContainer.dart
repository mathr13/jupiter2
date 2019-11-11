import 'package:flutter/material.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers.dart';
var res;
class FormContainer extends StatefulWidget {
  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  @override
  Widget build(BuildContext context) {
return GridView.count(
  primary: false,
  padding: const EdgeInsets.all(20),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  crossAxisCount: 5,
  children: <Widget>[
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('He\'d have you all unravel at the',style: TextStyle(fontSize: 4)),
      color: Colors.teal[100],
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Heed not the rabble',style: TextStyle(fontSize: 4)),
      color: Colors.teal[200],
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Sound of screams but the',style: TextStyle(fontSize: 4)),
      color: Colors.teal[300],
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Who scream',style: TextStyle(fontSize: 4)),
      color: Colors.teal[400],
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Revolution is coming...',style: TextStyle(fontSize: 4)),
      color: Colors.teal[500],
    ),
    Container(
      padding: const EdgeInsets.all(8),
      child: const Text('Revolution, they...',style: TextStyle(fontSize: 4),),
      color: Colors.teal[600],
    ),
  ],
);

  }
}

//import 'package:flutter/material.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
//List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
//  const StaggeredTile.count(2, 2),
//  const StaggeredTile.count(2, 2),
//  const StaggeredTile.count(2, 2),
////  const StaggeredTile.count(1, 1),
////  const StaggeredTile.count(2, 2),
////  const StaggeredTile.count(1, 2),
////  const StaggeredTile.count(1, 1),
////  const StaggeredTile.count(3, 1),
////  const StaggeredTile.count(1, 1),
////  const StaggeredTile.count(4, 1),
//];
//
//List<Widget> _tiles = const <Widget>[
//  const _Example01Tile(Colors.green),
//  const _Example01Tile(Colors.lightBlue),
//  const _Example01Tile(Colors.amber),
//  const _Example01Tile(Colors.brown),
//  const _Example01Tile(Colors.deepOrange),
//];
//
//class Example01 extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Example 01'),
//        ),
//        body: new Padding(
//            padding: const EdgeInsets.only(top: 12.0),
//            child: new StaggeredGridView.count(
//              crossAxisCount: 4,
//              staggeredTiles: _staggeredTiles,
//              children: _tiles,
//              mainAxisSpacing: 4.0,
//              crossAxisSpacing: 4.0,
//              padding: const EdgeInsets.all(4.0),
//            )));
//  }
//}
//
//class _Example01Tile extends StatelessWidget {
//  const _Example01Tile(this.backgroundColor);
//
//  final Color backgroundColor;
//
//  @override
//  Widget build(BuildContext context) {
//    return new Card(
//      color: backgroundColor,
//      child: new InkWell(
//        onTap: () {},
//        child: new Center(
//          child: new Padding(
//            padding: const EdgeInsets.all(4.0),
//          ),
//        ),
//      ),
//    );
//  }
//}