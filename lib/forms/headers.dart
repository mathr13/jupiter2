import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
class SectionHeader extends StatefulWidget {
  final String text;
  SectionHeader({this.text});
  @override
  _SectionHeaderState createState() => _SectionHeaderState();
}

class _SectionHeaderState extends State<SectionHeader> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
return Container(
  width: mediaQueryData.size.width/2,
    child: Padding(
        padding: new EdgeInsets.only(top:16.0 ,bottom: 16.0),

        child: StickyHeader(
          header: new Container(
            padding: const EdgeInsets.all(8.0),
            height: 50.0,
            color: Colors.blueGrey[700],
            alignment: Alignment.centerLeft,
            child: new Text(widget.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          content: new Container(),
        )
    )
    );
  }
}
