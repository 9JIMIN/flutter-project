import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './mypage_profile.dart';
import './mypage_product.dart';
import './mypage_settings.dart';

class MyPageColumn extends StatelessWidget {
  static const routeName = '/profile';
  final userId = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        MyPageProfile(userId),
        Divider(color: Colors.black12),
        MyPageProduct(userId),
        Divider(
          color: Colors.black12,
          thickness: 10,
        ),
        MyPageSettings(),
      ]),
    );
  }
}
