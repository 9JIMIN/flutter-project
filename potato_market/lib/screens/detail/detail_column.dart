import 'package:flutter/material.dart';

class DetailColumn extends StatelessWidget {
  static const routeName = '/detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    return Center(
      child: Text('$id'),
    );
  }
}
