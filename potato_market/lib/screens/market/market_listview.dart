import 'package:flutter/material.dart';
import 'package:potato_market/providers/provider_products.dart';
import 'package:provider/provider.dart';

import './market_product_item.dart';

class MarketListView extends StatefulWidget {
  @override
  _MarketListViewState createState() => _MarketListViewState();
}

class _MarketListViewState extends State<MarketListView> {
  Future<void> fetchProducts() async {
    Provider.of<ProviderProducts>(context, listen: false).fetchUp();
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderProducts>(
      builder: (_, products, __) => products.list.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: fetchProducts,
              child: ListView.builder(
                itemCount: products.list.length,
                itemBuilder: (ctx, i) {
                  return ProductItem(
                    products.list[i].id,
                    products.list[i].title,
                    products.list[i].price,
                    products.list[i].imageUrls[0],
                    products.list[i].createdAt,
                    products.list[i].likeCount,
                    products.list[i].chatCount,
                  );
                },
              ),
            ),
    );
  }
}
