import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItem{
  String id;
  String title='';
  String descripcion='';
  bool archived = false;
  bool complete = false;
  
  TodoItem(this.title,{this.descripcion, this.archived, this.complete});

  TodoItem.from(DocumentSnapshot snapshot):
  id = snapshot.documentID,
  title=snapshot['title'],
  descripcion=snapshot['descripcion'],
  archived=snapshot['archived'],
  complete=snapshot['complete'];

  Map<String, dynamic>toJson(){
    return{
      'title': title,
      'descripcion':descripcion,
      'archived':archived,
      'complete':complete,
    };
  }
}