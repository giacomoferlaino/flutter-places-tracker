import 'dart:io';

import 'package:flutter/foundation.dart';

import 'place_location.dart';

class Place {
  String id;
  String title;
  PlaceLocation location;
  File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });

  Place.parse(Map<String, dynamic> data) {
    final PlaceLocation savedLocation = PlaceLocation(
      latitude: data['loc_lat'],
      longitude: data['loc_lng'],
      address: data['address'],
    );
    id = data['id'];
    title = data['title'];
    location = savedLocation;
    image = File(data['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image.path,
      'loc_lat': location.latitude,
      'loc_lng': location.longitude,
      'address': location.address,
    };
  }
}
