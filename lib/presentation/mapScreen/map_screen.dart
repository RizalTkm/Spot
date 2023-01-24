import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spot/presentation/addSpotScreen/widget/current_location_access.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Marker> _markers = const <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(45.521563, -122.677433),
        infoWindow: InfoWindow(title: 'my position'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          onMapCreated: onMapCreated,
          markers: Set<Marker>.of(_markers),
          initialCameraPosition: const CameraPosition(
              target: LatLng(45.521563, -122.677433), zoom: 30)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final currentposition = await GetCurrentLocation.determinePosition();

          print(currentposition);

          setState(() {
            _markers.add(Marker(
                markerId: const MarkerId('2'),
                position: LatLng(
                    currentposition.latitude, currentposition.longitude)));
          });

          CameraPosition cameraPosition = CameraPosition(
              target:
                  LatLng(currentposition.latitude, currentposition.longitude));

          final GoogleMapController googleMapController = mapController;
          await mapController
              .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          setState(() {});
        },
        child: const Icon(Icons.gps_not_fixed),
      ),
    );
  }
}
