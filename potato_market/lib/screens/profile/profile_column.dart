import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileColumn extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
      ),
    );
  }
}
