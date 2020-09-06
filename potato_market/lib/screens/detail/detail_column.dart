import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:potato_market/helpers/db_helper_profile.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';
import '../../models/product.dart';
import '../../models/profile.dart';

class DetailColumn extends StatefulWidget {
  static const routeName = '/detail';

  @override
  _DetailColumnState createState() => _DetailColumnState();
}

class _DetailColumnState extends State<DetailColumn> {
  Future<Profile> getProfile(id) async {
    Profile profile = await DBHelperProfile.findById(id);
    return profile;
  }

  final ScrollController _scrollController = ScrollController();
  bool title = false;
  int carousel = 0;

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
        Provider.of<Products>(context, listen: false).findById(id);

    String formattedDate = Provider.of<Products>(context, listen: false)
        .formatedDate(product.createdAt);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          // 스크롤 가능한 영역
          SliverAppBar(
            title: title ? Text('${product.title}') : null,
            actions: [
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: product.id,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                          initialPage: 0,
                          aspectRatio: 1,
                          onPageChanged: (index, _) {
                            setState(() {
                              carousel = index;
                            });
                          }),
                      items: product.imageUrls.map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                url,
                                fit: BoxFit.fitWidth,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    product.imageUrls.length > 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: product.imageUrls.map((url) {
                              int index = product.imageUrls.indexOf(url);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 3,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: carousel == index
                                      ? Colors.white
                                      : Colors.white54,
                                ),
                              );
                            }).toList(),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                          future: getProfile(product.sellerId),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/profile');
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(product.imageUrls[0]),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(snapshot.data.email),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Text('온도'),
                                        Icon(Icons.hot_tub)
                                      ],
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
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
      bottomNavigationBar: BottomAppBar(
          child: Container(
        height: 70,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            ),
            VerticalDivider(
              color: Colors.black54,
              endIndent: 5,
              indent: 5,
              thickness: 0.3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('가격제안 여부')
              ],
            ),
            Spacer(),
            FlatButton(
              child: Text(
                '채팅으로 거래하기',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            )
          ],
        ),
      )),
    );
  }
}
