import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

var db = DatabaseHelper();

class CustomHiddenField extends StatefulWidget {
  final String defaultValue;

  CustomHiddenField({@required this.defaultValue});

  @override _CustomHiddenFieldState createState() => _CustomHiddenFieldState();
}

class _CustomHiddenFieldState extends State<CustomHiddenField> {
  @override Widget build(BuildContext context) {
    var defaultV;
    db.fetchLabelFromGV(widget.defaultValue.split("##")[1]).then((res) {
      defaultV = res[0]['key'];
    });
    return TextFormField(initialValue: "defaultV");
  }
}