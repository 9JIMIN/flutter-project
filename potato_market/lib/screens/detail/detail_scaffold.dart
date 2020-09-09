import 'package:flutter/material.dart';
import 'package:potato_market/providers/provider_products.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_products.dart';
import '../../models/product.dart';
import '../../helpers/format_factory.dart';

// components
import './detail_appbar.dart';
import './detail_seller.dart';
import './detail_bottombar.dart';

class DetailScaffold extends StatefulWidget {
  static const routeName = '/detail';

  @override
  _DetailScaffoldState createState() => _DetailScaffoldState();
}

class _DetailScaffoldState extends State<DetailScaffold> {
  final ScrollController _scrollController = ScrollController();
  bool title = false;

  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 380) {
        setState(() {
          title = true;
        });
      } else {
        setState(() {
          title = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;

    Product product =
        Provider.of<ProviderProducts>(context, listen: false).findById(id);

    String formattedDate = FormatFactory.dateFormatter(product.createdAt);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          // 스크롤 가능한 영역
          DetailAppBar(title, product),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailSeller(product),
                      SizedBox(height: 10),
                      Divider(color: Colors.black54),
                      SizedBox(height: 10),
                      Text(
                        '${product.title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text('카테고리 - '),
                          Text(formattedDate),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        product.description,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('채팅 ${product.chatCount}개 - '),
                          Text('관심 ${product.likeCount}개 - '),
                          Text('조회 ${product.likeCount}개'), // 아직 없는 필드
                        ],
                      ),
                      SizedBox(height: 800),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: DetailBottomBar(product),
    );
  }
}
