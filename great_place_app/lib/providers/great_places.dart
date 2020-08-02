import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  // getter를 만들어서 진짜 _item이 외부에서 수정되는 것을 방지
  // 왜냐하면 외부에서 바꾸면 notifyListener가 발동을 안함. 그래서 데이터를 바꿔도 앱에 업데이트가 안되서 안좋음.
  List<Place> get items => _items;

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
  _items.add(newPlace);
  notifyListeners();
  } 
}