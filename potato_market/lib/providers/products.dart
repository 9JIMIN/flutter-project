import 'package:flutter/foundation.dart'; // ChangeNotifier
import 'package:potato_market/helpers/db_helper.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _list = [];
  List<Product> get list => _list;

  // add는 프로바이더를 이용하지 않음.

  // fetch
  // 처음에는(list가 비었을 때는) 상위 20개 제품을 추가
  // 뭐가 있을 때는 받은 date이후의 제품을 추가
  Future<void> fetchProducts() async {
    if (_list.isEmpty) {
      final initalProducts = await DBHelper.initData();
      _list = initalProducts;
    } else {
      final newProducts = await DBHelper.refreshData(_list[0].createdAt);
      _list = newProducts + _list;
    }

    notifyListeners();
  }

  // find
  Product findById(String id) =>
      _list.firstWhere((element) => element.id == id);

  // 날짜 변환기
  String formatedDate(DateTime createdAt) {
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

  // delete

  // downScroll
}
