import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class CarMap extends StatefulWidget {
  const CarMap({super.key});

  @override
  State<CarMap> createState() => _CarMapState();
}

class _CarMapState extends State<CarMap> {
  late GoogleMapController? mapController;
  final LatLng _initialPosition = const LatLng(
    41.2995,
    69.2401,
  ); // Toshkent koordinatalari
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  LatLng? _currentPosition;
  PolylinePoints polylinePoints = PolylinePoints();
  final String _googleApiKey = "AIzaSyDklE2adHNKrJzQ44X2iXULt2FOjOEm6Us";
  String _distance = '';
  String _duration = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentPosition!,
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition!, zoom: 15.0),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onDoubleTap(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: const InfoWindow(title: 'Selected Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  Future<void> _onTap(LatLng destination) async {
    if (_currentPosition == null) return;
    try {
      final String url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=$_googleApiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final legs = route['legs'][0];
          final distanceText = legs['distance']['text'];
          final durationText = legs['duration']['text'];

          List<LatLng> polylineCoordinates = [];
          final points = polylinePoints.decodePolyline(
            route['overview_polyline']['points'],
          );
          for (var point in points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }

          setState(() {
            _polylines.clear();
            _polylines.add(
              Polyline(
                polylineId: const PolylineId('route'),
                points: polylineCoordinates,
                color: Colors.blue,
                width: 5,
              ),
            );
            _distance = distanceText;
            _duration = durationText;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onDoubleTapDown: (details) {
              mapController
                  ?.getLatLng(
                    ScreenCoordinate(
                      x: details.localPosition.dx.round(),
                      y: details.localPosition.dy.round(),
                    ),
                  )
                  .then((latLng) {
                    if (latLng != null) _onDoubleTap(latLng);
                  });
            },
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 11.0,
              ),
              markers: _markers,
              polylines: _polylines,
              onTap: _onTap,
            ),
          ),
          if (_distance.isNotEmpty && _duration.isNotEmpty)
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Arrival: $_distance ($_duration)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
