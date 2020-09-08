import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';
import './format_factory.dart';

class DBHelperProduct {
  // 1. addProduct
  // 2. getNewProduct
  // 3. getBeforeProduct
  // 4. updateProduct
  // 5. deleteProduct

  // addProduct - 새제품 추가
  static Future<void> addProduct(
    String title,
    int price,
    String description,
    List<String> imageUrls,
  ) async {
    final DateTime createdAt = DateTime.now();
    final String sellerId = FirebaseAuth.instance.currentUser.uid;
    final String formattedPrice = FormatFactory.priceFormatter(price);
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

  // getNewProducts - 최신 20개
  static Future<List<Product>> getNewProducts() async {
    final QuerySnapshot query = await FirebaseFirestore.instance
        .collection('products')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .get();

    final List<Product> productList = FormatFactory.toProductList(query);
    return productList;
  }

  // getBeforeProducts - 받은 날짜 이전 20개
  static Future<List<Product>> getBeforeProducts(DateTime date) async {
    final QuerySnapshot query = await FirebaseFirestore.instance
        .collection('products')
        .orderBy('createdAt', descending: true)
        .where('createdAt', isLessThan: date)
        .limit(20)
        .get();

    final List<Product> productList = FormatFactory.toProductList(query);
    return productList;
  }

  // updateProduct
  // deleteProduct
}
