import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prueba_bd/models/todoItem.dart';

class TodosPage extends StatefulWidget {
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CollectionReference _todosRef;
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    _setupTodosPage();
  }

  void _setupTodosPage() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _user = user;
      _todosRef = Firestore.instance
          .collection('users')
          .document(user.uid)
          .collection('todos');
    });
  }

  Widget _buildBody() {
    if (_todosRef == null) {
      return Center(
        child: LinearProgressIndicator(),
      );
    } else {
      return StreamBuilder(
          stream: _todosRef.reference().snapshots(),
          builder: _buildTodoList,
      );
    }
  }

  Widget _buildTodoList(context, snapshot) {
    if (!snapshot.hasData) {
      return Center(
        child: Text('${snapshot.error} ${_user.uid}'),
      );
    } else {
      if (snapshot.data.documents.length == 0) {
        return _buildEmptyMessage();
      } else {
        return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            TodoItem item = TodoItem.from(document);
            return Dismissible(
              key: Key(item.id),
              background: Container(
                color: Theme.of(context).primaryColorDark,
                child: Center(
                  child: Text(
                    'Archive',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onDismissed: (DismissDirection direction) {
                document.reference.updateData({'archived': true});
              },
              child: Card(
                child: CheckboxListTile(
                  title: Text(item.title),
                  subtitle: Text(item.descripcion),
                  value: item.complete,
                  onChanged: (bool value) {
                    document.reference.updateData({'complete': value});
                  },
                ),
              ),
            );
          }).toList(),
        );
      }
    }
  }

  Widget _buildEmptyMessage() {
    return Center(
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.check,
            size: 45.0,
            color: Colors.blueGrey,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Text(
            'no hay nadaloooo',
            style: TextStyle(color: Colors.blueGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
      ),
      body: _buildBody(),
    );
  }
}
