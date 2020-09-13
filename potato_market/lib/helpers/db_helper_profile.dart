import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile.dart';
import './storage_helper.dart';

class DBHelperProfile {
  // profile 생성
  static Future<void> addProfile(
    String name,
    String email,
  ) async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final defaultImageUrl = await StorageHelper.getDefaultUserUrl();
    final myDoc = FirebaseFirestore.instance.collection('profiles').doc(uid);

    await myDoc.set({
      'name': name,
      'email': email,
      'image': defaultImageUrl,
      'category': ['전자', '의류'],
      'area': ['서울', '부산'],
      'temperature': 365,
    });
  }

  // id로 profile 가져오기
  static Future<Profile> getProfileById(String uid) async {
    final myDoc = FirebaseFirestore.instance.collection('profiles').doc(uid);
    final snapshot = await myDoc.get();
    final Map<String, dynamic> doc = snapshot.data();

    return Profile(
      name: doc['name'],
      email: doc['email'],
      image: doc['image'],
      area: doc['area'],
      category: doc['category'],
      temperature: doc['temperature'],
    );
  }

  // likeProducts 전체 문서 가져오기
  static Future<List<String>> getLikeProductsIdList(String uid) async {
    final myLikeProductsId = await FirebaseFirestore.instance
        .collection('profiles')
        .doc(uid)
        .collection('likeProductsId')
        .get();
    final snapshotList = myLikeProductsId.docs;
    List<String> ids = [];
    snapshotList.map((snapshot) => ids.add(snapshot.data()['id']));

    return ids;
  }

  // likeProducts에 문서 추가하기
  static Future<void> addLikeProductId(String uid, String productId) async {
    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(uid)
        .collection('likeProductsId')
        .doc(productId)
        .set({});
  }

  // likeProducts에 문서 제거하기
  static Future<void> deleteLikeProductId(String uid, String productId) async {
    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(uid)
        .collection('likeProductsId')
        .doc(productId)
        .delete();
  }
}
