import 'dart:io';

import 'package:ecoveloapp/app/core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewStationService extends BaseApiClient {
  Future<BaseResp<dynamic>> getNewStation() async {
    return request<dynamic>(
      Method.get,
      "http://192.168.1.6:8000/cluster-centers",
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<dynamic>> getNearBy(
    LatLng center,
    int radius,
    String category,
  ) async {
    String apiKey = "";
    if (Platform.isAndroid) {
      apiKey = "AIzaSyCZOad7gTnNB1nLY91zGjzVpX5e6apJTLs";
    } else {
      apiKey = "AIzaSyA4fFbkn59HI6adqfj422CEfPm0lPLL5ME";
    }
    return request<dynamic>(
      Method.get,
      AppApi.getRecogetNearBy(
          center.latitude, center.longitude, radius, category, apiKey),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
