import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../models/product.dart';

class DBHelper {
  // 1. create
  // 2. initData
  // 3. refreshData
  // -. getImageUrls

  // create
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

  // initData
  static Future<List<Product>> initData() async {
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
    return itemsList; // 상위 20개
  }

  // refreshData
  static Future<List<Product>> refreshData(DateTime date) async {
    final QuerySnapshot query = await FirebaseFirestore.instance
        .collection('products')
        .orderBy('createdAt', descending: true)
        .where('createdAt', isGreaterThan: date) // 받은 시간이후의 문서
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
    return itemsList; // date기준 상위 문서들
  }

  // 이미지 asset을 받아서 스토리지에 저장후, url을 리턴 
  static Future<List<String>> getImageUrls(List<Asset> assets) async {
    final String sellerId = FirebaseAuth.instance.currentUser.uid;
    final StorageReference ref = FirebaseStorage.instance.ref().child(sellerId);
    List<String> urls = List<String>();

    for (var image in assets) {
      ByteData byteData = await image.getByteData(quality: 50);
      List<int> imageData = byteData.buffer.asUint8List();
      final photoRef = ref.child(DateTime.now().toString() + '.jpg');
      final finRef = await photoRef.putData(imageData).onComplete;
      final String downloadUrl = await finRef.ref.getDownloadURL();
      urls.add(downloadUrl);
    }

    return urls;
  }

  static Future<List<String>> getPotatoUrl() async{
    List<String> urls = List<String>();
    final ref = FirebaseStorage.instance.ref().child('default-images').child('potato.png');
    final url = await ref.getDownloadURL();
    urls.add(url);
    return urls;
  }
}
