import 'dart:convert';

import 'package:http/http.dart' as http;
import '../secret.dart';

const GOOGLE_API_KEY = KEY;

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude,}) { // 뒤에 알파벳 바꾸면 마커 알파벳 바뀜.
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlacesAddress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    print(json.decode(response.body));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}