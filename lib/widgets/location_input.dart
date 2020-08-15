import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';

import '../pages/map_page.dart';
import '../models/place_location.dart';
import '../services/location_service.dart';

class LocationInput extends StatefulWidget {
  final void Function(double latitude, double longitude) onSelectLocation;

  LocationInput(this.onSelectLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationService locationService = GetIt.instance.get<LocationService>();
  String _previewImagePath;

  void _showPreview(double latitude, double longitude) {
    final String staticMapImageURL = locationService.getLocationImageURL(
      latitude: latitude,
      longitude: longitude,
    );
    setState(() {
      _previewImagePath = staticMapImageURL;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final LocationData locationData = await Location().getLocation();
      _showPreview(locationData.latitude, locationData.longitude);
      widget.onSelectLocation(
        locationData.latitude,
        locationData.longitude,
      );
    } catch (err) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final PlaceLocation selectedLocation =
        await Navigator.of(context).push<PlaceLocation>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapPage(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) return;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectLocation(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );
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
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
