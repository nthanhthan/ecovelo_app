import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewStaton extends GetView<NewStationController> {
  const MapViewStaton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            controller.center.latitude,
            controller.center.longitude,
          ),
          zoom: 15,
        ),
        markers: controller.markers,
      ),
    );
  }
}
