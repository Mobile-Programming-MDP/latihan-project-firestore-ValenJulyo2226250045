import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const GoogleMapsScreen(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _cameraPosition;
  late Set<Marker> _markers;
  late MarkerId _markerId;

  void initState() {
    super.initState();
    _cameraPosition = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 15,
    );
    _markers = {};
    _markerId =
        MarkerId(widget.latitude.toString() + widget.longitude.toString());
    _markers.add(Marker(
      MarkerId : _markerId,
      position : LatLng(widget.latitude, widget.longitude),
      InfoWindow : const InfoWindow(
        title : "Your Location",
        snippet : "your current location is here",
      )
    ))
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Maps"),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
          Future.delayed(const Duration(milliseconds: 500), (){
            controller.showMarkerInfoWindow(_markerId);
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: _getLocation, label: const Text("To Your Location"),
      icon: const Icon(icon.directions_car),),
    )
    
  }
}
