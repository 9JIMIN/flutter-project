import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text('프로필 화면'),
    );
  }
}
