class Product {
  final String title;
  final int price;
  final String description;
  final DateTime createdAt;
  final List imageUrls;
  final String sellerId;
  final int likeCount;
  final int chatCount;

  Product({
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
