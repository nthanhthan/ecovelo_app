import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class NewStationController extends GetxController {
  late MapController mapController;
  List<StationModel> listStation = [];
  BitmapDescriptor? marker;
  final RxList<NewStationModel> _newListStation = RxList<NewStationModel>();
  set newListStation(List<NewStationModel> value) =>
      _newListStation.value = value;
  // ignore: invalid_use_of_protected_member
  List<NewStationModel> get newListStation => _newListStation.value;
  List<LatLng> newStation = const [
    LatLng(16.0607486, 108.24185681),
    LatLng(16.06374389, 108.21738959),
    LatLng(16.06873164, 108.22288313),
    LatLng(16.0757949, 108.2175882),
  ];
  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  //late StationHttpService _stationHttpService;

  late NewStationService _newStationService;

  Set<Marker> markers = {};

  LatLng center = const LatLng(16.0706181, 108.2240623);

  final RxString _lastUpdateAI = "".obs;
  String get lastUpdateAI => _lastUpdateAI.value;
  set lastUpdateAI(String value) => _lastUpdateAI.value = value;

  final RxInt _newJourney = 20.obs;
  int get newJourney => _newJourney.value;
  set newJourney(int value) => _newJourney.value = value;

  @override
  Future<void> onInit() async {
    lastUpdateAI = Prefs.getString(AppKeys.lastUpdateAI);
    _newStationService = Get.find<NewStationService>();
    _newStationService.getNewStation();
    super.onInit();
  }

  @override
  onReady() {
    addNewStation().then((value) {
      isLoading = true;
    });
  }

  Future<void> addNewStation() async {
    newListStation = [];
    LoadingAnswer loading = LoadingAnswer();
    loading.showLoadingAnswer();
    getListStation().then((value) async {
      listStation = value;
      for (var station in newStation) {
        String address = await getAddressFromCoordinatesStation(station);
        newListStation.add(
          NewStationModel(
            stationModel: StationModel(
              address: address,
              isNewStation: true,
              lat: station.latitude,
              lng: station.longitude,
            ),
          ),
        );
      }
      _newListStation.refresh();
      _getPlacesNearby().then((value) {
        isLoading = true;
        _newListStation.refresh();
        loading.hideLoading();
      });
    });
    Prefs.saveString(
      AppKeys.lastUpdateAI,
      DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()),
    );
    lastUpdateAI = DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now());
  }

  Future<List<StationModel>> getListStation() async {
    // _stationHttpService = Get.put<StationHttpService>(StationHttpService());
    // final result = await _stationHttpService.getListStation();
    // listStation = [];
    // if (result.isSuccess() && result.data != null) {
    //   listStation = result.data ?? [];
    // }
    return listStation;
  }

  Future<String> getAddressFromCoordinatesStation(LatLng station) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      station.latitude,
      station.longitude,
    );
    Placemark placemark = placemarks.first;

    String address = '';

    address =
        "${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.administrativeArea}, ${placemark.country}";
    return address;
  }

  Future<void> _getPlacesNearby() async {
    for (var i = 0; i < newListStation.length; i++) {
      var station = newListStation[i];
      List<LatLng> restaurant = await getListPlacesService(
        station.stationModel,
        200,
        "restaurant",
      );
      List<LatLng> school = await getListPlacesService(
        station.stationModel,
        500,
        "school",
      );
      List<LatLng> hotel = await getListPlacesService(
        station.stationModel,
        200,
        "lodging",
      );
      List<LatLng> busStation = await getListPlacesService(
        station.stationModel,
        1000,
        "bus_station",
      );
      newListStation[i].serviceStationModel = ServiceStationModel(
        restaurant: ServiceItem(
          name: "Restaurant",
          listPlaces: restaurant,
          num: restaurant.length,
          url: AssetsConst.restaurantIc,
        ),
        hotel: ServiceItem(
          name: "Hotel",
          listPlaces: hotel,
          num: hotel.length,
          url: AssetsConst.hotelIc,
        ),
        school: ServiceItem(
          name: "School",
          listPlaces: school,
          num: school.length,
          url: AssetsConst.schoolIc,
        ),
        busStation: ServiceItem(
          name: "Bus Station",
          listPlaces: busStation,
          num: busStation.length,
          url: AssetsConst.busIc,
        ),
      );
    }
  }

  Future<List<LatLng>> getListPlacesService(
    StationModel? stationModel,
    int radius,
    String category,
  ) async {
    List<LatLng> placeNear = [];
    final result = await _newStationService.getNearBy(
        LatLng(stationModel?.lat ?? 0, stationModel?.lng ?? 0),
        radius,
        category);
    if (result.isSuccess() && result.data != null) {
      final places = result.data['results'];
      for (var place in places) {
        placeNear.add(LatLng(place['geometry']['location']['lat'],
            place['geometry']['location']['lng']));
      }
    }
    return placeNear;
  }

  Future<void> createMarkers(NewStationModel newStationModel) async {
    marker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)), // kích thước của biểu tượng
      AssetsConst.station, // đường dẫn đến file hình ảnh
    );
    markers = {};
    center = LatLng(newStationModel.stationModel?.lat ?? 0,
        newStationModel.stationModel?.lng ?? 0);
    markers.add(Marker(
      position: center,
      markerId: const MarkerId("center"),
      infoWindow: const InfoWindow(title: "Center"),
      icon: marker!,
    ));
    if (newStationModel.serviceStationModel != null) {
      ServiceItem? serviceItemRestaurant =
          newStationModel.serviceStationModel!.restaurant;
      ServiceItem? serviceItemHotel =
          newStationModel.serviceStationModel!.hotel;
      ServiceItem? serviceItemSchool =
          newStationModel.serviceStationModel!.school;
      ServiceItem? serviceItemBusStation =
          newStationModel.serviceStationModel!.busStation;
      markers.addAll(creatMarkersService(0, serviceItemRestaurant));
      markers.addAll(creatMarkersService(1, serviceItemHotel));
      markers.addAll(creatMarkersService(2, serviceItemSchool));
      markers.addAll(creatMarkersService(3, serviceItemBusStation));
    }
    Get.toNamed(Routes.mapStation);
  }

  Set<Marker> creatMarkersService(int index, ServiceItem? serviceItem) {
    Set<Marker> markers = {};
    List<double> colorIcon = [
      BitmapDescriptor.hueYellow,
      BitmapDescriptor.hueGreen,
      BitmapDescriptor.hueRed,
      BitmapDescriptor.hueOrange,
    ];
    if (serviceItem != null) {
      if (serviceItem.listPlaces != null) {
        for (int j = 0; j < serviceItem.listPlaces!.length; j++) {
          LatLng place = serviceItem.listPlaces![j];
          markers.add(Marker(
            position: place,
            markerId: MarkerId("place_$index _ $j"),
            infoWindow: InfoWindow(title: serviceItem.name),
            icon: BitmapDescriptor.defaultMarkerWithHue(colorIcon[index]),
          ));
        }
      }
    }
    return markers;
  }
}
