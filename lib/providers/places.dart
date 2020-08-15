import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_places_tracker/services/location_service.dart';
import 'package:get_it/get_it.dart';

import '../models/place_location.dart';
import '../models/place.dart';
import '../services/db_service.dart';

class Places with ChangeNotifier {
  final LocationService locationService = GetIt.instance.get<LocationService>();
  static const String tableName = 'places';
  DBService _dbService;
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> _loadServices() async {
    if (_dbService == null) {
      _dbService = await GetIt.instance.getAsync<DBService>();
    }
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    await _loadServices();
    String address = await locationService.getLocationAddress(
      location.latitude,
      location.longitude,
    );
    final PlaceLocation completeLocation = PlaceLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address,
    );
    final Place newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: completeLocation,
    );
    _items.add(newPlace);
    await _dbService.insert(tableName, newPlace.toJson());
    notifyListeners();
  }

  Future<void> fetchAll() async {
    await _loadServices();
    final List<Map<String, dynamic>> dataList =
        await _dbService.getAll(tableName);
    _items = dataList.map((element) => Place.parse(element)).toList();
    notifyListeners();
  }
}
