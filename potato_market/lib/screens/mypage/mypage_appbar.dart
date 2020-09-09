import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPageAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  _MyPageAppBarState createState() => _MyPageAppBarState();
}

class _MyPageAppBarState extends State<MyPageAppBar> {
  final List<String> _dropdownValues = [
    '로그아웃',
    '회원탈퇴',
  ];

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text('나의 감자'),
      actions: [
        DropdownButton(
          icon: Icon(Icons.settings),
          items: _dropdownValues
              .map(
                (value) => DropdownMenuItem(
                  child: Text(value),
                  value: value,
                ),
              )
              .toList(),
          onChanged: (String value) {
            FirebaseAuth.instance.signOut();
          },
          value: _dropdownValues.first,
        )
      ],
    );
  }
}
