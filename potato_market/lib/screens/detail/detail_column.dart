import 'package:flutter/material.dart';
import './detail_appbar.dart';

class DetailColumn extends StatelessWidget {
  static const routeName = '/detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: DetailAppBar(),
      body: Center(
        child: Text('$id'),
      ),
    );
  }
}
