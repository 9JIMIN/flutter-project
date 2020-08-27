import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:potato_market/screens/auth_screen.dart';

import './screens/edit_screen.dart';
import './screens/chat_screen.dart';
import './screens/profile_screen.dart';
import './screens/market_screen.dart';
import './screens/loading_screen.dart';

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
        unselectedWidgetColor: Colors.black54,
        errorColor: Colors.red,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.brown[800],
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }
          if (snapshot.hasData) {
            return MarketScreen();
          }
          return AuthScreen();
        },
      ),
      // MarketScreen(),
      routes: {
        EditScreen.routeName: (_) => EditScreen(),
        ChatScreen.routeName: (_) => ChatScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
      },
    );
  }
}
