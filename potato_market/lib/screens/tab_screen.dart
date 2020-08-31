import 'package:flutter/material.dart';
import 'package:potato_market/screens/chat/chat_appbar.dart';
import 'package:potato_market/screens/profile/profile_appbar.dart';

import './market/market_listview.dart';
import './market/market_appbar.dart';
import './edit/edit_scaffold.dart';
import './chat/chat_listview.dart';
import './profile/profile_column.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    if (index == 1) {
      Navigator.of(context).pushNamed(EditScaffold.routeName);
    } else {
      setState(() {
        _selectedPageIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'appbar': MarketAppBar(),
        'body': MarketListView(),
      },
      {
        // edit screen
      },
      {
        'appbar': ChatAppBar(),
        'body': ChatListView(),
      },
      {
        'appbar': ProfileAppBar(),
        'body': ProfileColumn(),
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pages[_selectedPageIndex]['appbar'],
      body: _pages[_selectedPageIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('홈'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_iridescent),
            title: Text('글쓰기'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('채팅'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            title: Text('프로필'),
          ),
        ],
      ),
    );
  }
}
