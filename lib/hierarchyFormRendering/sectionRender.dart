import 'dart:convert';
import 'dart:convert';
import 'package:jupiter/forms/formRendering.dart';

import 'radio.dart';
import 'package:flutter/material.dart';
import 'package:jupiter/forms/jsondata.dart';
import 'textfield.dart';
import 'button.dart';
import 'package:jupiter/forms/formRenderedElements.dart';
import 'package:jupiter/hierarchyFormRendering/switch.dart';
var parentSectionColumnDivision;
var parentSectionRowDivision;
MediaQueryData mediaQueryData;
bool isRowTrue;
bool renderTrue=true;
class SectionRender extends StatefulWidget {
  final String formData;
  final int rowIndex;
  final int colIndex;
  final double parentCellWidth;
  Map item;

  SectionRender({this.formData,this.parentCellWidth,this.colIndex,this.rowIndex});
  @override
  _SectionRenderState createState() => _SectionRenderState();
}

class _SectionRenderState extends State<SectionRender> {
  void initState() {
    super.initState();
    var parentSectionData = json.decode(listingData);
    for(int i=0;i<parentSectionData['data']['FORM'][0]['sections'][0]['sections'].length;i++) {
     if(parentSectionData['data']['FORM'][0]['sections'][0]['sections'][i]['colIndex']==widget.colIndex&&
         parentSectionData['data']['FORM'][0]['sections'][0]['sections'][i]['rowIndex']==widget.rowIndex) {
        widget.item=parentSectionData['data']['FORM'][0]['sections'][0]['sections'][i]['definition'][0];
       renderTrue = true;
       print("Render ${widget.rowIndex}");
       print("Render col ${widget.colIndex}");
       break;
     }
     else
       renderTrue=false;
    }
  }
//  bool isRenderTrue(){
//    var parentSectionData = json.decode(listingData);
//    for(int i=0;i<parentSectionData['data']['FORM'][0]['sections'][0]['sections'].length;i++) {
//      if(parentSectionData['data']['FORM'][0]['sections'][0]['sections'][i]['colIndex']==widget.colIndex&&
//          parentSectionData['data']['FORM'][0]['sections'][0]['sections'][i]['rowIndex']==widget.rowIndex) {
//        widget.item=parentSectionData['data']['FORM'][0]['sections'][0]['sections'][i]['definition'][0];
//        renderTrue = true;
//        print("Render ${widget.rowIndex}");
//        print("Render col ${widget.colIndex}");
//        return true;
//      }
//      else
//        renderTrue=false;
//      return false;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return renderTrue==true?Column(
      children: <Widget>[
        CoreForm()
      // CustomText(item: widget.item,),
//       CustomText(),
//        CustomText(),
//        CustomRadio()

      ],
    )
    //CustomRadio()
   // CustomSwitch(text: "${widget.rowIndex} ${widget.colIndex}",)
        :ButtonRender();

  }
//  int i;
//  List<Widget> childSection(BuildContext context) {
//    List<Widget> listWidget = new List<Widget>();
//    print(parentSectionRowDivision);
//    print(parentSectionColumnDivision);
//    for ( i = 0; i < (parentSectionRowDivision); i++) {
//      listWidget.add(Container(
////          height:mediaQueryData.size.height / parentSectionRowDivision,
//
//          child:Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//
//              children:childRow(context)
////        <Widget>[
////          Container(
////            child: Text("This is $i "),
////          ),
////          Container(
////            child: Text("This is $i "),
////          )
////        ],
//
//          )));
//    }
//    return listWidget;
//  }
//
//  List<Widget> childRow(BuildContext context) {
//    List<Widget> listWidget = new List<Widget>();
//    print(parentSectionRowDivision);
//    print(parentSectionColumnDivision);
//    for (int j = 0; j < (parentSectionColumnDivision); j++) {
//      listWidget.add( Container(
//          width:widget.parentCellWidth / parentSectionColumnDivision,
//          child:CustomSwitch()
//        //Text("This is Column $i $j "),
//      )
//
//      );
//
////      for (int j = 0; j < (parentSectionColumnDivision); j++) {
////        listWidget.add(Row(
////          crossAxisAlignment: CrossAxisAlignment.start,
////          children: <Widget>[
////            Container(
////              child: Text("This is $i $j "),
////            )
////          ],
////        ));
////      }
//    }
//    return listWidget;
//  }

}
