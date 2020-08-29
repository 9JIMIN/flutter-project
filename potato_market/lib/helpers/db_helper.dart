import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

// fetch(상위 20개), more(아래 20개 추가),
// CRUD

class DBHelper {
  static Future<void> create(
    String title,
    int price,
    String description,
    List<String> imageUrls,
  ) async {
    final DateTime createdAt = DateTime.now();
    final String sellerId = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance.collection('products').add({
      'title': title,
      'price': price,
      'description': description,
      'imageUrls': imageUrls,
      'sellerId': sellerId,
      'createdAt': createdAt,
      'likeCount': 0,
      'chatCount': 0,
    });
  }

  static Future<QuerySnapshot> getData(bool isUp, DateTime fromThis) async {
    if (isUp == true) {
      // 위로 업데이트
      final QuerySnapshot query = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('createdAt', descending: true)
          .limit(20)
          .get();
      return query;
    } else {
      return null;
    }
  }

  static Future<List<String>> getImageUrls(List<Asset> assets) async {
    final String sellerId = FirebaseAuth.instance.currentUser.uid;
    final StorageReference ref = FirebaseStorage.instance.ref().child(sellerId);
    List<String> urls = List<String>();

    for (var image in assets) {
      ByteData byteData = await image.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      final photoRef = ref.child(DateTime.now().toString() + '.jpg');
      final finRef = await photoRef.putData(imageData).onComplete;
      final String downloadUrl = await finRef.ref.getDownloadURL();
      urls.add(downloadUrl);
    }

    return urls;
  }
}
