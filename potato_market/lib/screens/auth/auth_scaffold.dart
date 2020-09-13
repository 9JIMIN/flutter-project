import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './auth_form.dart';
import '../../helpers/db_helper_profile.dart';
import '../../helpers/auth_helper.dart';
import '../../providers/provider_me.dart';

class AuthScaffold extends StatefulWidget {
  @override
  _AuthScaffoldState createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<AuthScaffold> {
  var _isLoading = false;

  Future<void> _submitAuthForm(
    String name,
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      // 로그인
      if (isLogin) {
        await AuthHelper.signIn(
          email,
          password,
        );
      }
      // 회원가입
      else {
        await AuthHelper.createUser(
          email,
          password,
        );
        await DBHelperProfile.addProfile(
          name,
          email,
        );
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
