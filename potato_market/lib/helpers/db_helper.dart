import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../models/product.dart';

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

  static Future<List<Product>> getData(DateTime time) async {
    // 위로 업데이트
    final QuerySnapshot query = await FirebaseFirestore.instance
        .collection('products')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .get();

    final List<Product> itemsList = [];
    for (var docsnapshot in query.docs) {
      final doc = docsnapshot.data();
      final product = Product(
        title: doc['title'],
        price: doc['price'],
        description: doc['description'],
        createdAt: doc['createdAt'].toDate(), // 타임스템프를 Date로 바꿔줘야함.
        imageUrls: doc['imageUrls'],
        sellerId: doc['sellerId'],
        likeCount: doc['likeCount'],
        chatCount: doc['chatCount'],
      );
      itemsList.add(product);
    }
    return itemsList;
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
