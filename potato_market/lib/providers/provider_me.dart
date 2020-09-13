import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helpers/db_helper_profile.dart';

import '../models/profile.dart';

class ProviderMe with ChangeNotifier {
  List<String> _likeProductsId = [];
  Profile _myProfile;

  List get likeProducts => _likeProductsId;
  Profile get myProfile => _myProfile;
  String get uid => FirebaseAuth.instance.currentUser.uid;

  // 내 계정 업데이트
  Future<void> fetchMyProfile() async {
    final Profile myProfile = await DBHelperProfile.getProfileById(uid);
    _myProfile = myProfile;

    notifyListeners();
  }

  // 내 좋아요 목록 업데이트
  Future<void> fetchMyLikeProductsId() async {
    final List<String> likeProductsId =
        await DBHelperProfile.getLikeProductsIdList(uid);
    _likeProductsId = likeProductsId;

    notifyListeners();
  }

  // 좋아요 클릭
  Future<void> toggleLikeProductsId(String productId) async {
    if (_likeProductsId.contains(productId)) {
      await DBHelperProfile.deleteLikeProductId(uid, productId);
      _likeProductsId.remove(productId);
    } else {
      await DBHelperProfile.addLikeProductId(uid, productId);
      _likeProductsId.add(productId);
    }

    notifyListeners();
  }
}
