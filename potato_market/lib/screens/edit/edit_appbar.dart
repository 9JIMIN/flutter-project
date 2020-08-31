import 'package:flutter/material.dart';

class EditAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text('글쓰기'),
    );
  }
}
