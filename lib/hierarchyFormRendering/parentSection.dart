import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jupiter/forms/jsondata.dart';
import 'package:jupiter/hierarchyFormRendering/childSection.dart';
var parentSectionColumnDivision;
var parentSectionRowDivision;
MediaQueryData mediaQueryData;
bool isRowTrue;
class ParentSection extends StatefulWidget {
 final String formData;
  ParentSection({this.formData});
  @override
  _ParentSectionState createState() => _ParentSectionState();
}

class _ParentSectionState extends State<ParentSection> {
  void initState() {
    super.initState();
    var parentSectionData = json.decode(listingData);
    parentSectionColumnDivision = parentSectionData['data']['FORM'][0]['cols'];
    parentSectionRowDivision = parentSectionData['data']['FORM'][0]['rows'];
  }

  @override
  Widget build(BuildContext context) {
     mediaQueryData = MediaQuery.of(context);
    return Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.center,
          children: childSection(context),
        )
    );
  }
int i;
  List<Widget> childSection(BuildContext context) {
    List<Widget> listWidget = new List<Widget>();
//    print(parentSectionRowDivision);
//    print(parentSectionColumnDivision);
    for ( i = 0; i < (parentSectionRowDivision); i++) {
      listWidget.add(Container(
//        height:mediaQueryData.size.height / parentSectionRowDivision,

          child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:childRow(context)
//        <Widget>[
//          Container(
//            child: Text("This is $i "),
//          ),
//          Container(
//            child: Text("This is $i "),
//          )
//        ],

          )));
    }
    return listWidget;
  }

  List<Widget> childRow(BuildContext context) {
    List<Widget> listWidget = new List<Widget>();
    print(parentSectionRowDivision);
    print(parentSectionColumnDivision);
    var parentSectionWidth=mediaQueryData.size.width / parentSectionColumnDivision;
    for (int j = 0; j < (parentSectionColumnDivision); j++) {
      listWidget.add( Container(
        width:mediaQueryData.size.width / parentSectionColumnDivision,
        child:ChildrenSections(parentCellWidth: parentSectionWidth,)
        //Text("This is Column $i $j "),
      )

      );

//      for (int j = 0; j < (parentSectionColumnDivision); j++) {
//        listWidget.add(Row(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Container(
//              child: Text("This is $i $j "),
//            )
//          ],
//        ));
//      }
    }
    return listWidget;
  }

}
