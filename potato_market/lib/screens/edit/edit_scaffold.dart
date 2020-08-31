import 'package:flutter/material.dart';

import './edit_appbar.dart';
import './edit_form.dart';

class EditScaffold extends StatelessWidget {
  static const routeName = '/edit';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditAppBar(),
      body: EditForm(),
    );
  }
}
