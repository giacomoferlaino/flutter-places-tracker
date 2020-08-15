import 'dart:convert';

import 'package:http/http.dart';

class GoogleMapsProxy {
  static const double defaultMapZoom = 16;
  static String staticMap(
    String apiKey, {
    double latitude,
    double longitude,
    double zoom = defaultMapZoom,
    int width = 600,
    int height = 300,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=$zoom&size=${width}x$height&maptype=roadmap&markers=color:red%7Alabel:C%7C$latitude,$longitude&key=$apiKey';
  }

  static Future<String> locationAddress(
    String apiKey, {
    double latitude,
    double longitude,
  }) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
    final Response response = await get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
