import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:potato_market/screens/detail/detail_column.dart';

// screens
import './screens/auth/auth_scaffold.dart';
import './screens/edit/edit_scaffold.dart';
import './screens/chat/chat_listview.dart';
import './screens/profile/profile_column.dart';
import './screens/loading_screen.dart';
import './screens/tab_screen.dart';

// providers

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
        errorColor: Colors.red[800],
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
            return TabScreen();
          }
          return AuthScaffold();
        },
      ),
      routes: {
        DetailColumn.routeName: (_) => DetailColumn(),
        EditScaffold.routeName: (_) => EditScaffold(),
        ChatListView.routeName: (_) => ChatListView(),
        ProfileColumn.routeName: (_) => ProfileColumn(),
      },
    );
  }
}
