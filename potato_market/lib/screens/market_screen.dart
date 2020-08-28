import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:potato_market/screens/chat_screen.dart';

import './edit_screen.dart';
import './chat_screen.dart';
import './profile_screen.dart';
import '../widgets/product_item.dart';

class MarketScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.of(context).pushReplacementNamed('/');
      } else if (index == 1) {
        Navigator.of(context).pushNamed(EditScreen.routeName);
      } else if (index == 2) {
        Navigator.of(context).pushNamed(ChatScreen.routeName);
      } else if (index == 3) {
        Navigator.of(context).pushNamed(ProfileScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('감자마켓'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('test')
            .orderBy('createDate', descending: true)
            .get(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Text('someting went wrong');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final List<DocumentSnapshot> data = snapshot.data.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx, index) {
                final item = data[index].data();
                return ProductItem(
                  item['title'].toString(),
                  item['price'].toString(),
                  item['imageUrls'][0].toString(),
                  item['seller'].toString(),
                  item['createDate'],
                  item['likeCount'].toString(),
                  item['chatCount'].toString(),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
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
