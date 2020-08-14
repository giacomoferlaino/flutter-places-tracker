import 'package:flutter/material.dart';
import 'package:flutter_places_tracker/services/location_service.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationService locationService = GetIt.instance.get<LocationService>();
  String _previewImagePath;

  Future<void> _getCurrentLocation() async {
    final LocationData locationData = await Location().getLocation();
    final String staticMapImageURL = locationService.getLocationImageURL(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
    );
    setState(() {
      _previewImagePath = staticMapImageURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImagePath == null
              ? Center(
                  child: const Text(
                    'No Location Chosen',
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.network(
                  _previewImagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: const Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: const Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
