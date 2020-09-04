import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';
import './price_formatter.dart';

class DBHelper {
  // 1. create
  // 2. initData
  // 3. refreshData

  // create
  static Future<void> create(
    String title,
    int price,
    String description,
    List<String> imageUrls,
  ) async {
    final DateTime createdAt = DateTime.now();
    final String sellerId = FirebaseAuth.instance.currentUser.uid;
    final String formattedPrice = priceFormatter(price);
    final String id = Uuid().v4();
    
    await FirebaseFirestore.instance.collection('products').add({
      'id': id,
      'title': title,
      'price': price,
      'formattedPrice': formattedPrice,
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
        id: doc['id'],
        title: doc['title'],
        price: doc['formattedPrice'],
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
        id: doc['id'],
        title: doc['title'],
        price: doc['formattedPrice'],
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
}
