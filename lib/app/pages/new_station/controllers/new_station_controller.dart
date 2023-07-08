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
  List<CoordinateStationModel> newStation = [];
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

  final RxInt _newJourney = 0.obs;
  int get newJourney => _newJourney.value;
  set newJourney(int value) => _newJourney.value = value;

  @override
  Future<void> onInit() async {
    lastUpdateAI = Prefs.getString(AppKeys.lastUpdateAI);
    _newStationService = Get.find<NewStationService>();
    getCountRent();
    super.onInit();
  }

  @override
  onReady() {
    getListRecommendStation().then((value) {
      addNewStation().then((value) {
        isLoading = true;
      });
    });
  }

  Future<void> getListRecommendStation() async {
    final result = await _newStationService.getNewStation();
    if (result.isSuccess() && result.data != null) {
      newStation = result.data as List<CoordinateStationModel>;
    }
  }

  Future<void> getCountRent() async {
    final result = await _newStationService.getCountRent();
    if (result.isSuccess() && result.response?.data != null) {
      newJourney = result.response!.data as int;
    }
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
              lat: station.lat,
              lng: station.lng,
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

  Future<String> getAddressFromCoordinatesStation(
      CoordinateStationModel station) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      station.lat!,
      station.lng!,
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
