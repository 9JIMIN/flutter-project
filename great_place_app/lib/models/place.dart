import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longtitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longtitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final File image; // File 데이타타입은 플러터가 아닌, 다트에서 쓰이는거. 그래서 dart.io를 가져와야함.
  final PlaceLocation location;

  Place({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.location,
  });
}
