import 'package:flutter/material.dart';

class MyPageSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.lightbulb_outline),
          title: Text('내 동네 설정'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.lightbulb_outline),
          title: Text('키워드 알림'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.lightbulb_outline),
          title: Text('자주 묻는 질문'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.lightbulb_outline),
          title: Text('앱 설정'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.lightbulb_outline),
          title: Text('공지사항'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.lightbulb_outline),
          title: Text('공지사항'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.lightbulb_outline),
          title: Text('공지사항'),
          onTap: () {},
        ),
      ],
    );
  }
}
