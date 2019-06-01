import 'package:flutter/material.dart';
import 'package:prueba_bd/pages/forgotPassword.dart';
import 'package:prueba_bd/pages/login.dart';
import 'package:prueba_bd/pages/mainTabs.dart';
import 'package:prueba_bd/pages/register.dart';

Map<String, WidgetBuilder> buildAppRoutes(){
  return{
    '/login': (BuildContext context) => LoginPage(),
    '/register': (BuildContext context) => RegisterPage(),
    '/forgotpassword': (BuildContext context) => ForgotPasswordPage(),
    '/maintabs': (BuildContext context) => MainTabs(),
  };
}