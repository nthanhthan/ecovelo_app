import 'package:ecoveloapp/app/core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class JourneyDetailConroller extends GetxController {
  DetailJouneyModel? detailJouneyModel;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  final RxString _startStation = "".obs;
  String get startStation => _startStation.value;

  final RxString _endStation = "".obs;
  String get endStation => _endStation.value;

  final List<LatLng> _listTrip = [];
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  LatLng? currentPosition;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null && Get.arguments is DetailJouneyModel) {
      detailJouneyModel = Get.arguments as DetailJouneyModel;
      if (detailJouneyModel!.detailTrip != null) {
        currentPosition = LatLng(
          double.parse(detailJouneyModel!.detailTrip!.first.lat ?? "0"),
          double.parse(detailJouneyModel!.detailTrip?.first.lng ?? "0"),
        );
      }
      bool check = createListTrip();
      if (check) {
        isLoading = true;
      }
    }
    if (detailJouneyModel != null) {
      if (detailJouneyModel!.coordinateBeginStaion != null) {
        _startStation.value = await getAddressFromCoordinates(
            detailJouneyModel!.coordinateBeginStaion!);
      }
      if (detailJouneyModel!.coordinateEndStaion != null) {
        _endStation.value = await getAddressFromCoordinates(
            detailJouneyModel!.coordinateEndStaion!);
      }
    }
    super.onInit();
  }

  Future<String> getAddressFromCoordinates(CoordinateModel? position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      double.parse(position?.lat ?? "0"),
      double.parse(position?.lng ?? "0"),
    );
    Placemark placemark = placemarks.first;
    return "${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.administrativeArea}, ${placemark.country}";
  }

  String convertDateTime() {
    DateTime startDate =
        DateTime.fromMillisecondsSinceEpoch(detailJouneyModel!.beginTimeRent!);
    DateTime endDate =
        DateTime.fromMillisecondsSinceEpoch(detailJouneyModel!.endTimeRent!);
    String formatDate = DateFormat("MMM dd, yyyy").format(endDate);
    return "${startDate.hour} : ${startDate.minute} - ${endDate.hour} : ${endDate.minute}  $formatDate";
  }

  bool createListTrip() {
    if (detailJouneyModel != null && detailJouneyModel!.detailTrip != null) {
      for (var element in detailJouneyModel!.detailTrip!) {
        _listTrip.add(LatLng(double.parse(element.lat ?? "0"),
            double.parse(element.lng ?? "0")));
      }
      // ignore: invalid_use_of_protected_member
      polylines.value.add(Polyline(
        polylineId: const PolylineId("route"),
        points: _listTrip,
        color: AppColors.success,
        width: 5,
      ));
    }
    return true;
  }
}
