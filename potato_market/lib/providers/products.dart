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

  // delete

  // downScroll
}
