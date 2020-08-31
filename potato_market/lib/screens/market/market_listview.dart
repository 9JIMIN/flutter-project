import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';
import './market_product_item.dart';

class MarketListView extends StatefulWidget {
  @override
  _MarketListViewState createState() => _MarketListViewState();
}

class _MarketListViewState extends State<MarketListView> {
  Future<void> fetchProducts() async{
    await Provider.of<Products>(context).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Products>(context, listen: false).fetchProducts(),
        builder: (ctx, snapshot) {
          // print(snapshot.connectionState);
          if (snapshot.hasError) {
            return Center(
              child: Text('에러발생..'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<Products>(
              child: Center(
                child: Text('올라온 제품이 없습니다.'),
              ),
              builder: (ctx, products, ch) => products.items.length == 0
                  ? ch
                  : RefreshIndicator(
                      onRefresh: fetchProducts,
                      child: ListView.builder(
                        itemCount: products.items.length,
                        itemBuilder: (ctx, i) {
                          return ProductItem(
                            products.items[i].title,
                            products.items[i].price,
                            products.items[i].imageUrls[0],
                            products.items[i].createdAt,
                            products.items[i].likeCount,
                            products.items[i].chatCount,
                          );
                        },
                      ),
                    ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
