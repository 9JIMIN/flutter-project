import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBHelperUser {
  static Future<void> create( // 유저 uid로 문서 생성.
      UserCredential user, String username, String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.user.uid)
        .set({
      'username': username,
      'email': email,
    });
  }
}
