import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // final LatLng _center = const LatLng(45.521563, -122.677433);
  // late GoogleMapController _controller;

  // void _onMapCreated(GoogleMapController controller) {
  //   _controller = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        //mapType: MapType.normal,
        //onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 11.0,
        ),
      ),
    );
  }
}
