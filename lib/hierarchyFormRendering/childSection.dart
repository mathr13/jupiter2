import 'dart:convert';
import 'package:jupiter/hierarchyFormRendering/sectionRender.dart';
import 'package:flutter/material.dart';
import 'package:jupiter/forms/jsondata.dart';
import 'package:jupiter/hierarchyFormRendering/switch.dart';
var parentSectionColumnDivision;
var parentSectionRowDivision;
MediaQueryData mediaQueryData;
bool isRowTrue;
class ChildrenSections extends StatefulWidget {
  final String formData;
  final double parentCellWidth;
  ChildrenSections({this.formData,this.parentCellWidth});
  @override
  _ChildrenSectionsState createState() => _ChildrenSectionsState();
}

class _ChildrenSectionsState extends State<ChildrenSections> {
  void initState() {
    super.initState();
    var parentSectionData = json.decode(listingData);
    parentSectionColumnDivision = parentSectionData['data']['FORM'][0]['sections'][0]['cols'];
    parentSectionRowDivision = parentSectionData['data']['FORM'][0]['sections'][0]['rows'];
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: childSection(context),
        )
    );
  }
  int i;
  List<Widget> childSection(BuildContext context) {
    List<Widget> listWidget = new List<Widget>();
    print(parentSectionRowDivision);
    print(parentSectionColumnDivision);
    for ( i = 0; i < (parentSectionRowDivision); i++) {
      listWidget.add(Container(
//          height:mediaQueryData.size.height / parentSectionRowDivision,

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
//    print(parentSectionRowDivision);
//    print(parentSectionColumnDivision);
    for (int j = 0; j < (parentSectionColumnDivision); j++) {
      listWidget.add( Container(
          width:widget.parentCellWidth / parentSectionColumnDivision,
          child:SectionRender(rowIndex: j,colIndex: i,)
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
