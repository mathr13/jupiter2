import 'package:flutter/material.dart';
import 'package:jupiter/Screens/Views/home.dart';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

var db = DatabaseHelper();

class CustomButton extends StatefulWidget {
  final String wsId;
  final Map item;
  final List<dynamic> buttons;

  CustomButton({@required this.buttons,this.wsId,this.item});

  @override _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override Widget build(BuildContext context) {
    getButtonData(widget.wsId, widget.item['id']);
    return Container(
      height: 50*(widget.buttons.length).toDouble(),
      child: ListView.builder(
        itemCount: widget.buttons.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index) {
          // return ListTile(
          //   title: Center(child: Text(widget.buttons[index]['label'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25))),
          // );
          return RaisedButton(
            onPressed: () {
              var operationOnButtonClick = buttons[index]['operation'];
              switch (operationOnButtonClick) {
                case "SAVE": {
                  //TODO: save
                }
                break;
                case "CLOSE": {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>Menus(),fullscreenDialog: true));
                }
                break;
              }
            },
            child: Text(widget.buttons[index]['label']),
          );
        },
      )
    );
  }
}

void getButtonData(String wsId, String containerId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var tId = sharedPreferences.get("TemplateId");
  buttons = await db.fetchButtonData(wsId,containerId, sharedPreferences.get("TemplateId"));
}