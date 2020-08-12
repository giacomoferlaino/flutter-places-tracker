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
    id = data['id'];
    title = data['title'];
    location = data['location'];
    image = File(data['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image.path,
    };
  }
}
