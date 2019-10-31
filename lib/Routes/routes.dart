import 'package:flutter/material.dart';
import 'package:jupiter/Screens/Views/splashScreen.dart';
import 'package:jupiter/Screens/Views/signIn.dart';
import 'package:jupiter/Screens/Views/forgotPassword.dart';


final routes = {
  '/' :          (BuildContext context) => new SplashScreen(),
  '/forget':         (BuildContext context) => new ForgetPassword(),

  '/signin':         (BuildContext context) => new SignIn(),

};