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
  int _selectedIndex = 0;

  void _selectPage(int index) {
    if (index == 1) {
      Navigator.of(context).pushNamed(EditScaffold.routeName).then((value) {
        // 물건을 올리면 홈에서 볼 수 있도록..
        setState(() {
          index = 0;
        });
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Widget> _appbars = [
    MarketAppBar(),
    null, // edit screen
    ChatAppBar(),
    ProfileAppBar(),
  ];
  final List<Widget> _bodys = [
    MarketListView(),
    Text('글쓰기'), // IndexedStack에 null이면 에러남.
    ChatListView(),
    ProfileColumn(),
  ];

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _selectPage,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('홈'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
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
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbars[_selectedIndex],
      body: IndexedStack(
        index: _selectedIndex,
        children: _bodys,
      ),
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
    );
  }
}
