import 'package:flutter/material.dart';
import 'package:potato_market/screens/chat_screen.dart';
import 'package:provider/provider.dart';

import './edit_screen.dart';
import './chat_screen.dart';
import './profile_screen.dart';
import '../widgets/product_item.dart';
import '../helpers/db_helper.dart';
import '../providers/products.dart';

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
        future: Provider.of<Products>(context, listen: false).fetchProducts(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Text('someting went wrong');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<Products>(
              child: Center(
                child: Text('뭐가 없다.'),
              ),
              builder: (ctx, products, ch) => products.items.length == 0
                  ? ch
                  : ListView.builder(
                      itemCount: products.items.length,
                      itemBuilder: (ctx, i) {
                        return ProductItem(
                          products.items[i].title,
                          products.items[i].price,
                          products.items[i].imageUrls[0],
                          products.items[i].createdAt,
                          products.items[i].likeCount,
                          products.items[i].chatCount,
                        );
                      },
                    ),
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
