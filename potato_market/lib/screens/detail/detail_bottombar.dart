import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_me.dart';

class DetailBottomBar extends StatefulWidget {
  final product;
  DetailBottomBar(this.product);

  @override
  _DetailBottomBarState createState() => _DetailBottomBarState();
}

class _DetailBottomBarState extends State<DetailBottomBar> {
  @override
  Widget build(BuildContext context) {
    final _isLike = Provider.of<ProviderMe>(context, listen: false)
        .likeProducts
        .contains(widget.product.id);
    Future<void> _clickFavorite() async {
      await Provider.of<ProviderMe>(context, listen: false)
          .toggleLikeProductsId(widget.product.id);
      setState(() {});
    }

    return BottomAppBar(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
              icon: Icon(_isLike ? Icons.favorite : Icons.favorite_border),
              onPressed: _clickFavorite,
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
                  widget.product.price,
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
      ),
    );
  }
}
