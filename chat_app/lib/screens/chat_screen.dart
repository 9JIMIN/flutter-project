import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('this works'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/QbPwSCOH0B9Ycbkkh9MC/messages')
              .snapshots()
              .listen((data) {
            data.documents.forEach((document) {
              print(document['text']);
            });
          }); 
          // 스냅샷은 DB의 변화를 감지한다.
          // 그래서 DB에 새로운 문서가 추가되면 알아서 실행이 됨.
        },
      ),
    );
  }
}
