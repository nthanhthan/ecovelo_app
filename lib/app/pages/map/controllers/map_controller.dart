import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapController extends GetxController {
  BitmapDescriptor? marker;
  BitmapDescriptor? markerRed;
  Set<Marker> myMarkers = {};
  StationModel? _currentStation;
  late StationHttpService _stationHttpService;

  TextEditingController stationTextController = TextEditingController();
  FocusNode searchNode = FocusNode();

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  Position? position;

  final String _keyStation = '';

  Future<bool> customMarker() async {
    marker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(30, 30)), // kích thước của biểu tượng
      AssetsConst.station, // đường dẫn đến file hình ảnh
    );
    markerRed = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(30, 30)), // kích thước của biểu tượng
      AssetsConst.stationRed, // đường dẫn đến file hình ảnh
    );
    return true;
  }

  final RxnString _myAddress = RxnString();
  set myAddress(String value) => _myAddress.value = value;
  String? get getMyAddress => _myAddress.value;

  final RxnString _stationAddress = RxnString();
  set stationAddress(String value) => _stationAddress.value = value;
  String? get getStationAddress => _stationAddress.value;

  late List<StationModel> listStation;

  // ignore: prefer_collection_literals

  @override
  Future<void> onInit() async {
    await getListStation();
    customMarker().then((value) {
      _getCurrentLocation().then((value) {
        setMarker();
        isLoading = true;
      });
    });
    super.onInit();
  }

  Future<List<StationModel>> getListStation() async {
    _stationHttpService = Get.put<StationHttpService>(StationHttpService());
    final result = await _stationHttpService.getListStation();
    listStation = [];
    if (result.isSuccess() && result.data != null) {
      listStation = result.data ?? [];
    }
    return listStation;
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Người dùng từ chối cho phép truy cập vị trí
        // Hiển thị thông báo yêu cầu quyền truy cập vị trí
      }
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      getMyPositionCurrent();
      // Xử lý dữ liệu vị trí
    }
  }

  Future<bool> getMyPositionCurrent() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getAddressFromCoordinates();
    return true;
  }

  void setMarker() {
    for (StationModel value in listStation) {
      final markerStation = Marker(
          markerId: MarkerId(value.id.toString()),
          position: LatLng(value.lat ?? 0, value.lng ?? 0),
          icon: checkNumbicycle(value.numBicycle ?? 0) ? marker! : markerRed!,
          onTap: () {
            onMarkerTapped(value);
          });
      myMarkers.add(markerStation);
    }
  }

  Future<void> onMarkerTapped(StationModel station) async {
    getMyPositionCurrent().then((value) {
      _currentStation = station;
      var progress = ProcessingDialog.show();
      getAddressFromCoordinatesStation(
              LatLng(station.lat ?? 0, station.lng ?? 0))
          .then((value) {
        progress.hide();
      });
      progress.hide();
      const MapView().showBottomSheet(
        Get.context!,
        station,
      );
    });
  }

  bool checkNumbicycle(int num) {
    if (num > 0 && num < 8) {
      return false;
    } else if (num > 8) {
      return true;
    }
    return false;
  }

  bool checkBikeLeft(int num) {
    if (num <= 0) {
      return false;
    }
    return true;
  }

  String? caculateDistance(LatLng to) {
    if (position != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        position!.latitude,
        position!.longitude,
        to.latitude,
        to.longitude,
      );
      if (distanceInMeters > 1000) {
        return "${distanceInMeters.toInt() / 1000} km";
      }
      return "${distanceInMeters.toInt()} m";
    }
    return null;
  }

  Future<void> getAddressFromCoordinates() async {
    if (position != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );
      Placemark placemark = placemarks.first;

      String address = '';

      address =
          "${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.administrativeArea}, ${placemark.country}";
      myAddress = address;
    }
  }

  Future<bool> getAddressFromCoordinatesStation(LatLng station) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      station.latitude,
      station.longitude,
    );
    Placemark placemark = placemarks.first;

    String address = '';

    address =
        "${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.administrativeArea}, ${placemark.country}";
    stationAddress = address;
    return true;
  }

  Future<void> goClick() async {
    launchMapsUrl(_currentStation?.lat ?? 0, _currentStation?.lng ?? 0);
  }

  bool checkMyPositon() {
    return position != null;
  }

  void launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use

      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<List<StationModel>> loadListStation(String key) async {
    if (key.isNotEmpty && ((key.trim().isEmpty) || _keyStation == key.trim())) {
      return listStation;
    }
    try {
      List<StationModel> lisStationBySearch = [];
      lisStationBySearch = listStation
          .where((element) =>
              element.address!.toLowerCase().contains(key.toLowerCase()))
          .toList();
      return lisStationBySearch;
    } catch (e) {
      return [];
    }
  }

  void chooseStation(StationModel station) {
    onMarkerTapped(station);
  }
}
