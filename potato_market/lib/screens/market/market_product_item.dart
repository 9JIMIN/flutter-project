import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../detail/detail_column.dart';
import '../../providers/products.dart';

class ProductItem extends StatelessWidget {
  final id;
  final title;
  final price;
  final thumbnail;
  final createdAt;
  final likeCount;
  final chatCount;

  ProductItem(
    this.id,
    this.title,
    this.price,
    this.thumbnail,
    this.createdAt,
    this.likeCount,
    this.chatCount,
  );

  @override
  Widget build(BuildContext context) {
    String formattedDate = Provider.of<Products>(context, listen: false).formatedDate(createdAt);
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pushNamed(
              DetailColumn.routeName,
              arguments: id, // 문서에 고유의 아이디를 인자로 쓰고 싶은데.. 뭐 없을까?
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: id,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(thumbnail),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              price,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Text('$likeCount' + '-' + '$chatCount'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Divider(
            color: Theme.of(context).primaryColor,
            height: 1,
          ),
        ),
      ],
    );
  }
}
