import 'package:flutter_places_tracker/models/google_maps_proxy.dart';

class LocationService {
  final String _apiKey;

  LocationService(this._apiKey);

  String getLocationImageURL({double latitude, double longitude}) {
    return GoogleMapsProxy.staticMap(_apiKey,
        latitude: latitude, longitude: longitude);
  }
}
