import 'package:flutter/material.dart';

class MyPageProduct extends StatelessWidget {
  final userId;
  MyPageProduct(this.userId);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 120,
          width: 120,
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: Icon(Icons.library_books),
                  ),
                ),
                Text('판매내역'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 120,
          width: 120,
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: Icon(Icons.shopping_basket),
                  ),
                ),
                Text('구매내역'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 120,
          width: 120,
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: Icon(Icons.favorite),
                  ),
                ),
                Text('관심목록'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
