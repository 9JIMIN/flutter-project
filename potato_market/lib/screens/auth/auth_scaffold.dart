import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './auth_form.dart';
import '../../helpers/db_helper_profile.dart';

class AuthScaffold extends StatefulWidget {
  @override
  _AuthScaffoldState createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<AuthScaffold> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  Future<void> _submitAuthForm(
    String name,
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // DB에도 유저정보 저장하기
        await DBHelperProfile.create(authResult, name, email);

        setState(() {
          _isLoading = false;
        });
      }
    } catch (err) {
      var message = '에러발생';
      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}