import 'package:flutter/material.dart';

class DetailBottomBar extends StatelessWidget {
  final product;
  DetailBottomBar(this.product);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
      ),
    );
  }
}
