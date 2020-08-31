import 'package:flutter/material.dart';

class MarketAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text('감자마켓'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
    );
  }
}
