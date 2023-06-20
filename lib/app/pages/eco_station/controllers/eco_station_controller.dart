import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class EcoStationController extends GetxController {
  TextEditingController stationTextController = TextEditingController();
  final RxList<StationModel> _foodResponses = <StationModel>[].obs;
  set foodResponses(List<StationModel> value) => _foodResponses.value = value;
  // ignore: invalid_use_of_protected_member
  List<StationModel> get foodResponses => _foodResponses.value;
  FocusNode searchNode = FocusNode();
  List<StationModel>? stations;
  Future<List<StationModel>> loadListStation(String key) async {
    // if (key.isNotEmpty && ((key.trim().isEmpty) || _keyStation == key.trim())) {
    //   return listStation;
    // }
    try {
      List<StationModel> lisStationBySearch = [];
      // lisStationBySearch = listStation
      //     .where((element) =>
      //         element.address!.toLowerCase().contains(key.toLowerCase()))
      //     .toList();
      return lisStationBySearch;
    } catch (e) {
      return [];
    }
    
  }
}
