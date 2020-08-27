import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String username,
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _username = '';
  var _userEmail = '';
  var _password = '';
  var _isLogin = true;

  void _trySubmit() {
    _formKey.currentState.save();
    widget.submitFn(
      _username,
      _userEmail,
      _password,
      _isLogin,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          child: Text(
            '감자마켓',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('nickname'),
                        decoration: InputDecoration(labelText: '닉네임'),
                        onSaved: (value) {
                          _username = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('email'),
                      decoration: InputDecoration(labelText: '메일주소'),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    TextFormField(
                      key: ValueKey('pass'),
                      decoration: InputDecoration(labelText: '패스워드'),
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        child: Text(_isLogin ? '로그인' : '가입'),
                        onPressed: _trySubmit,
                      ),
                    if (!widget.isLoading)
                      FlatButton(
                        child: Text(_isLogin ? '새로 만들기' : '이미 계정이 있음'),
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
