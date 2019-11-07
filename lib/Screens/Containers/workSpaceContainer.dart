import 'package:flutter/material.dart';

class WorkSpaceContainer extends StatefulWidget {
  final String titleString;
  WorkSpaceContainer({ this.titleString });
  @override _WorkSpaceContainerState createState() => _WorkSpaceContainerState();
}

class _WorkSpaceContainerState extends State<WorkSpaceContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleString),
      ),
    );
  }
}