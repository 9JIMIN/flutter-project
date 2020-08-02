import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longtitude;
  final String address;

  PlaceLocation({
    @required this.latitude,
    @required this.longtitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image; // File 데이타타입은 플러터가 아닌, 다트에서 쓰이는거. 그래서 dart.io를 가져와야함.

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
