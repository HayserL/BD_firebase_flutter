import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba_bd/pages/login.dart';
import 'package:prueba_bd/pages/mainTabs.dart';
import 'package:prueba_bd/routes.dart';
import 'package:prueba_bd/theme.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatefulWidget {
  TodoApp({Key key}) : super(key: key);

  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Widget _rootPage = LoginPage();

   Future<Widget> getRootPage() async =>
    await FirebaseAuth.instance.currentUser() == null 
      ? LoginPage()
      : MainTabs();

  @override
  initState() {
    super.initState();
    getRootPage().then((Widget page){
      setState((){
        _rootPage = page;
      });
    });
  } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       title: 'Todos App',
       home: _rootPage,
       routes: buildAppRoutes(),
       theme: buildAppTheme(),
    );
  }
}

