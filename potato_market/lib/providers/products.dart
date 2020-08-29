import 'package:flutter/material.dart';
import '../models/product.dart';
import '../helpers/db_helper.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items => _items;

  Future<void> fetchProducts() async {
    final query = await DBHelper.getData(true, null);

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
    _items = itemsList;

    notifyListeners();
  }
}
