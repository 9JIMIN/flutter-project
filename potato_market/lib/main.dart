import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:potato_market/providers/provider_products.dart';
import 'package:provider/provider.dart';

// screens
import './screens/detail/detail_scaffold.dart';
import './screens/auth/auth_scaffold.dart';
import './screens/edit/edit_scaffold.dart';
import './screens/chat/chat_listview.dart';
import './screens/mypage/mypage_column.dart';
import './screens/loading_screen.dart';
import './screens/tab_screen.dart';

// providers
import './providers/provider_products.dart';

// helpers
import './helpers/custom_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderProducts(),
      child: MaterialApp(
        title: 'potato market',
        theme: ThemeData(
          // appbar theme
          appBarTheme: AppBarTheme.of(context).copyWith(
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // button theme
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          primarySwatch: Colors.brown,
          unselectedWidgetColor: Colors.black54,
          errorColor: Colors.red[800],
          pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
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
          DetailScaffold.routeName: (_) => DetailScaffold(),
          EditScaffold.routeName: (_) => EditScaffold(),
          ChatListView.routeName: (_) => ChatListView(),
          MyPageColumn.routeName: (_) => MyPageColumn(),
        },
      ),
    );
  }
}
