import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../models/place.dart';
import '../services/db_service.dart';

class Places with ChangeNotifier {
  static const String tableName = 'places';
  DBService _dbService;
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> _loadServices() async {
    if (_dbService == null) {
      _dbService = await GetIt.instance.getAsync<DBService>();
    }
  }

  Future<void> addPlace(String title, File image) async {
    await _loadServices();
    final Place newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: null,
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
