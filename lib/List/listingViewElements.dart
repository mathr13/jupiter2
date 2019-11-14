import 'package:flutter/material.dart';
import 'dart:core';
import 'package:jupiter/Databasehelper/databaseHelper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jupiter/forms/formRendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool isHeader;

class ListingViewElements extends StatefulWidget {
  List<dynamic> data;
  List labelList;
  bool isSlidableTrue;
  String label;
  MediaQueryData mediaQueryData;
  ListingViewElements  (
      this.data,this.labelList,this.isSlidableTrue,this.label);
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
     widget.mediaQueryData = MediaQuery.of(context);
    return new ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(thickness: 0.0,);
      },
        itemCount:widget.data == null ? 0 : widget.data.length+1,
        itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                    onTap: ()async{
                      if(widget.label=="ITEMTYPE") {
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString("TemplateId", 'inputItemForm');
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                            App(isEditTrue: false,isDrawerTrue: false,formTitle: "INPUT FORM",)));
                      }
                    },
                        child:Container(
                            color:index==0?Colors.grey:Colors.white,
                            child:Column(
                      children:buildRows(widget.data,index)
        )));
      });
  }
  int i;

  List<Widget> buildRows(dynamic list,index) {
    List<Widget> listHeader = new List<Widget>();

      if (index == 0) {
        isHeader = true;
        i=index;
      }
      else {
        isHeader = false;
        i=index;
      }
      listHeader.add((Slidable(
          actionPane: SlidableDrawerActionPane(),
          secondaryActions:widget.isSlidableTrue==true? <Widget>[
            IconSlideAction(
              caption: 'View',
              color: Colors.black26,
              icon: Icons.view_list,
              onTap: () async{

              },
            ),
            IconSlideAction(
              caption: 'Edit',
              color: Colors.black45,
              icon: Icons.edit,
              onTap: () async{

                _onEdit(index);
              },
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => print('Delete'),
            ),
          ]:null,child:Row(
        children: buildRowColumn(list),
      ))));
    return listHeader;
  }


  List<Widget> buildRowColumn(dynamic list) {
    List<Widget> listHeader = new List<Widget>();
    for (int j = 0; j < widget.labelList.length; j++) {
      listHeader.add((Container(
      width:(widget.mediaQueryData.size.width/2)-30,
          child:Padding(padding: EdgeInsets.all(8.0),
//          new ListTile(
//          title:
          child:Column(children: <Widget>[
        new Container(
            child:isHeader==true?(new Text(widget.labelList[j]['label'].toString(),textAlign:TextAlign.left, style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0,color: Colors.white,)
            )):
    (widget.labelList[j]['dataSource'][0]['secondaryEntityName']!=null?
    (new FutureBuilder(
                future: db.getListingLabel(widget.labelList[j]['dataSource'][0]['secondaryEntityName'].toUpperCase(),widget.labelList[j]['dataSource'][0]['secondaryValueMember'],list[i-1][widget.labelList[j]['id'].toString()].toString(),widget.labelList[j]['dataSource'][0]['secondaryDisplayMember']),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) return  CircularProgressIndicator();
//                  Text(list[i-1][widget.labelList[j]['id'].toString()].toString(), style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
                  return new Text(snapshot.data.toString(), textAlign:TextAlign.left,style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0));
                }
            )):
           new Text(list[i-1][widget.labelList[j]['dataSource'][0]['displayMember'].toString()].toString(),textAlign:TextAlign.left, style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)
          )
        )
        )
      ])))

    ));
    }
    return listHeader;
  }
  _onEdit(int index){
    for(int i=0;i<widget.data.length;i++)

    Navigator.push(context,MaterialPageRoute(builder: (context) =>App(isEditTrue: true, defaultData: widget.data[index],)));
    print(widget.data[index]);
    print(index);

  }



}
