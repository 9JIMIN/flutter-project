import 'package:flutter/material.dart';
import 'package:potato_market/helpers/db_helper.dart';

import '../../models/product.dart';
import './market_product_item.dart';

class MarketListView extends StatefulWidget {
  @override
  _MarketListViewState createState() => _MarketListViewState();
}

class _MarketListViewState extends State<MarketListView> {
  List<Product> _products = [];

  Future<void> fetchProducts() async {
    var result = await DBHelper.getData(null);
    setState(() {
      _products = result;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return _products.isEmpty
        ? Center(
            child: Text('제품이 없습니다.'),
          )
        : RefreshIndicator(
            onRefresh: fetchProducts,
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (ctx, i) {
                return ProductItem(
                  _products[i].title,
                  _products[i].price,
                  _products[i].imageUrls[0],
                  _products[i].createdAt,
                  _products[i].likeCount,
                  _products[i].chatCount,
                );
              },
            ),
          );
  }
}
