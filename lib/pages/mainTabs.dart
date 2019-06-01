import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:prueba_bd/pages/settings.dart';
import 'package:prueba_bd/pages/todos.dart';
import 'package:prueba_bd/pages/todosArchive.dart';

class MainTabs extends StatelessWidget {
  const MainTabs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: new Scaffold(
          body: TabBarView(
            children: <Widget>[
              ArchivePage(),
              TodosPage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: PreferredSize(
            preferredSize: Size(60.0,60.0),
            child: Container(
              height: 60.0,
              child: TabBar(
                labelColor: Theme.of(context).primaryColor,
                labelStyle: TextStyle(fontSize: 10.0),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.history),
                    text: 'Historial',
                  ),
                  Tab(
                    icon: Icon(Icons.list),
                    text: 'Todo',
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    text: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}