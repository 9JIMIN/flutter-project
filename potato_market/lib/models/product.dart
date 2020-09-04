class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final DateTime createdAt;
  final List imageUrls;
  final String sellerId;
  final int likeCount;
  final int chatCount;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.createdAt,
    this.imageUrls,
    this.sellerId,
    this.likeCount,
    this.chatCount,
  });
}
