import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceItem {
  String? name;
  int? num;
  List<LatLng>? listPlaces;
  String? url;
  ServiceItem({
    this.name,
    this.num,
    this.listPlaces,
    this.url,
  });
}
