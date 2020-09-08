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

  ScrollController _controller;

  _scrollListener() async {
    if (_controller.position.maxScrollExtent - _controller.position.pixels <
        1000) {
      await Provider.of<ProviderProducts>(context, listen: false).fetchDown();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    fetchProducts();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_scrollListener);
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
              child: Scrollbar(
                child: ListView.builder(
                  controller: _controller,
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
            ),
    );
  }
}
