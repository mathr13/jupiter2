import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jupiter/Screens/Views/signIn.dart';
import 'package:jupiter/Screens/Views/troy.dart';
import '../../main.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
@override
  _State createState() => _State();
}

class _State extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // new Future.delayed(const Duration(seconds: 3), () => Navigator.push(context,MaterialPageRoute(builder: (context) => SignIn())));
    if(isFirstLogin==true) {
      new Future.delayed(const Duration(seconds: 3), () => Navigator.push(context,MaterialPageRoute(builder: (context) => SignIn())));
    }else {
      new Future.delayed(const Duration(seconds: 3), () => Navigator.push(context,MaterialPageRoute(builder: (context) => Menus())));
      // new Future.delayed(const Duration(seconds: 3), () => Navigator.push(context,MaterialPageRoute(builder: (context) => Gridxo())));
    }
  }

    @override Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black,
        //or set color with: Color(0xFF0000FF)
      ));
      return Container(
        child: new DecoratedBox(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage('assets/images/_640 x 960-7.png'),
                fit: BoxFit.fill
            ),
          ),
        ),
      );
    }
  }

