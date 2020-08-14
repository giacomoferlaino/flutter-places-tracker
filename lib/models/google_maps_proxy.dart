class GoogleMapsProxy {
  static String staticMap(
    String apiKey, {
    double latitude,
    double longitude,
    int zoom = 16,
    int width = 600,
    int height = 300,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=$zoom&size=${width}x$height&maptype=roadmap&markers=color:red%7Alabel:C%7C$latitude,$longitude&key=$apiKey';
  }
}
