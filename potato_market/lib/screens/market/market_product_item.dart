import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../detail/detail_column.dart';

class ProductItem extends StatelessWidget {
  final title;
  final price;
  final thumbnail;
  final createdAt;
  final likeCount;
  final chatCount;

  ProductItem(
    this.title,
    this.price,
    this.thumbnail,
    this.createdAt,
    this.likeCount,
    this.chatCount,
  );

  String formatedDate() {
    List<String> hms = DateTime.now()
        .difference(createdAt)
        .toString()
        .split('.')[0]
        .split(':');
    String h = hms[0];
    String m = hms[1];
    String s = hms[2];

    String formatedString = '';
    if (h != '0') {
      int hours = int.parse(h);
      if (hours < 24) {
        formatedString = hours.toString() + '시간 전';
      } else if (hours > 24 && hours < 168) {
        formatedString = (hours / 24).round().toString() + '일 전';
      } else if (hours >= 168 && hours < 720) {
        formatedString = (hours / 168).round().toString() + '주 전';
      } else if (hours >= 720 && hours < 8760) {
        formatedString = (hours / 720).round().toString() + '개월 전';
      } else if (hours >= 8760) {
        formatedString = (hours / 8760).round().toString() + '년 전';
      }
      return formatedString;
    } else if (m != '00') {
      int minutes = int.parse(m);
      formatedString = minutes.toString() + '분 전';
      return formatedString;
    } else {
      int seconds = int.parse(s);
      formatedString = seconds.toString() + '초 전';
      return formatedString;
    }
  }

  String rev(str) => str.split('').reversed.join();
  String zeroDelete(str) => int.parse(str).toString();

  String formatedPrice() {
    String stringPrice = price.toString();
    var f = new NumberFormat('#,###');
    if (stringPrice.length <= 5) {
      // 10만원 미만
      return f.format(price) + '원';
    } else {
      // 10만원 이상이 되면, 억-만 단위를 붙여줌.
      var reversedString = rev(stringPrice);
      // 원
      var won = zeroDelete(rev(reversedString.substring(0, 4)));
      won = won == '0' ? '원' : ' ' + won + '원';

      // 만, 억
      var man = '';
      var ugk = '';
      int len = stringPrice.length;
      if (len >= 9) {
        man = zeroDelete(rev(reversedString.substring(4, 8)));
        ugk = zeroDelete(rev(reversedString.substring(8))) + '억 ';
      } else {
        man = zeroDelete(rev(reversedString.substring(4, len)));
      }
      man = man == '0' ? '' : man + '만';

      return ugk + man + won;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pushNamed(
              DetailColumn.routeName,
              arguments: createdAt, // 문서에 고유의 아이디를 인자로 쓰고 싶은데.. 뭐 없을까?
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
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
                              formatedDate(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              formatedPrice(),
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
