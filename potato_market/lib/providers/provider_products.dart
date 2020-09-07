import 'package:flutter/foundation.dart'; // for ChangeNotifier
import 'package:potato_market/helpers/db_helper_product.dart';

import '../models/product.dart';

class ProviderProducts with ChangeNotifier {
  List<Product> _list = [];
  List<Product> get list => _list;

  // add는 프로바이더를 이용하지 않음.

  // fetchUp
  Future<void> fetchUp() async {
    final productList = await DBHelperProduct.getNewProducts();
    _list = productList;
    notifyListeners();
  }

  // fetchDown
  Future<void> fetchDown(DateTime date) async{
    final productList = await DBHelperProduct.getBeforeProducts(date);
    _list = _list + productList;
    notifyListeners();
  }

  // find
  Product findById(String id) =>
      _list.firstWhere((element) => element.id == id);

  // delete

  // downScroll
}
