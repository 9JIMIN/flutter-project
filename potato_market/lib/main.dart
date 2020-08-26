import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/edit_screen.dart';
import './screens/chat_screen.dart';
import './screens/profile_screen.dart';
import './screens/market_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'potato market',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        unselectedWidgetColor: Colors.black54
      ),
      home: MarketScreen(),
      routes: {
        EditScreen.routeName: (_)=> EditScreen(),
        ChatScreen.routeName: (_)=> ChatScreen(),
        ProfileScreen.routeName: (_)=> ProfileScreen(),
      },
    );
  }
}
