import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile.dart';

class DBHelperProfile {
  static Future<void> create(
      // 유저 uid로 문서 생성.
      UserCredential user,
      String name,
      String email) async {
    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(user.user.uid)
        .set({
      'name': name,
      'email': email,
    });
  }

  static Future<Profile> findById(String id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('profiles').doc(id).get();
    Map<String, dynamic> doc = snapshot.data();
    final user = Profile(
      name: doc['name'],
      email: doc['email'],
    );
    return user;
  }
}
