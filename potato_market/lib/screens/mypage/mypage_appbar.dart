import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text('나의 감자'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(Icons.settings, color: Colors.white,),
              items: [
                DropdownMenuItem(
                  child: Text('로그아웃'),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text('회원탈퇴'),
                  value: 2,
                ),
              ],
              onChanged: (value) {
                if (value == 1) {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
