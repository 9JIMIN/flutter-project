import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  // getter를 만들어서 진짜 _item이 외부에서 수정되는 것을 방지
  // 왜냐하면 외부에서 바꾸면 notifyListener가 발동을 안함. 그래서 데이터를 바꿔도 앱에 업데이트가 안되서 안좋음.
  List<Place> get items => _items;

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlacesAddress(
        pickedLocation.latitude, pickedLocation.longtitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longtitude: pickedLocation.longtitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longtitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longtitude: item['loc_lng'],
                address: item['address']),
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> deletePlace(String id) async {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    DBHelper.delete('places', id);
  }
}
