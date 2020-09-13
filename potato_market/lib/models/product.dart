import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final DateTime createdAt;
  final bool isPullUp;
  final String category;
  final String area;
  final String thumbnailUrl;
  final List imageUrls;
  final String sellerId;
  final int likeCount;
  final int chatCount;
  final String state;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.createdAt,
    this.isPullUp,
    this.category,
    this.area,
    this.thumbnailUrl,
    this.imageUrls,
    this.sellerId,
    this.likeCount,
    this.chatCount,
    this.state,
  });
}
