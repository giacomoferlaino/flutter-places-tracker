import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_places_tracker/services/location_service.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import './providers/places.dart';
import './pages/places_list_page.dart';
import './pages/add_place_page.dart';
import './services/db_service.dart';
import './services/device_storage_service.dart';

GetIt getIt = GetIt.instance;

Future<void> initServices() async {
  getIt.registerLazySingletonAsync<DeviceStorageService>(() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    return DeviceStorageService(appDir);
  });
  getIt.registerLazySingletonAsync<DBService>(() async {
    final DBService dbService = DBService();
    await dbService.init('places.db');
    return dbService;
  });
  getIt.registerSingleton<LocationService>(LocationService());
}

void main() async {
  await initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListPage(),
        routes: {
          AddPlacePage.routeName: (context) => AddPlacePage(),
        },
      ),
    );
  }
}
