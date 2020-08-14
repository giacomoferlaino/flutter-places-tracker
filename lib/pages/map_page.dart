import 'package:flutter/material.dart';
import 'package:flutter_places_tracker/models/google_maps_proxy.dart';
import 'package:flutter_places_tracker/models/place_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  static const double _defaultLatitude = 37.4220;
  static const double _defaultLongitude = -122.0841;
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapPage({
    this.initialLocation = const PlaceLocation(
      latitude: _defaultLatitude,
      longitude: _defaultLongitude,
    ),
    this.isSelecting = false,
  });

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  PlaceLocation _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: GoogleMapsProxy.defaultMapZoom,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: LatLng(
                    _pickedLocation.latitude,
                    _pickedLocation.longitude,
                  ),
                ),
              },
      ),
    );
  }
}
