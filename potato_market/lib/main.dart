import 'package:flutter/material.dart';

import './screens/market_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'potato market',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MarketScreen(),
    );
  }
}
