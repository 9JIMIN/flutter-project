import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class FormatFactory {
  static List<Product> toProductList(QuerySnapshot query) {
    return query.docs.map((docsSnapshot) {
      final doc = docsSnapshot.data();
      return Product(
        id: doc['id'],
        title: doc['title'],
        price: doc['formattedPrice'],
        description: doc['description'],
        createdAt: doc['createdAt'].toDate(), // 타임스템프를 Date로 바꿔줘야함.
        imageUrls: doc['imageUrls'],
        sellerId: doc['sellerId'],
        likeCount: doc['likeCount'],
        chatCount: doc['chatCount'],
      );
    }).toList();
  }


  // 날짜 변환기
  static String dateFormatter(DateTime createdAt) {
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

  static String priceFormatter(int intPrice) {
    String rev(str) => str.split('').reversed.join();
    String zeroDelete(str) => int.parse(str).toString();

    String stringPrice = intPrice.toString();
    var f = new NumberFormat('#,###');
    if (stringPrice.length <= 5) {
      // 10만원 미만
      return f.format(intPrice) + '원';
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
}
