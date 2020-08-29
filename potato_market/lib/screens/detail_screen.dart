import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  @override
  Widget build(BuildContext context) {
  final id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('디테일'),
      ),
    );
  }
}
