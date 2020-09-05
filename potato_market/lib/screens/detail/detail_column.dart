import 'package:flutter/material.dart';
import 'package:potato_market/helpers/db_helper_profile.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';
import '../../models/product.dart';
import '../../models/profile.dart';

class DetailColumn extends StatelessWidget {
  static const routeName = '/detail';

  Future<Profile> getProfile(id) async {
    Profile profile = await DBHelperProfile.findById(id);
    return profile;
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
        slivers: <Widget>[
          // 스크롤 가능한 영역
          SliverAppBar(
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
              title: Text(product.title),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrls[0],
                  fit: BoxFit.cover,
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
                                    SizedBox(
                                      width: 10,
                                    ),
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
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.black54,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${product.title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('카테고리 - '),
                          Text(formattedDate),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        product.description,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('채팅 ${product.chatCount}개 - '),
                          Text('관심 ${product.likeCount}개 - '),
                          Text('조회 ${product.likeCount}개'),
                        ],
                      ),
                      SizedBox(
                        height: 800,
                      )
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
