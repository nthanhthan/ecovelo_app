import 'dart:io';

import 'package:ecoveloapp/app/core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewStationService extends BaseApiClient {
  Future<BaseResp<List<CoordinateStationModel>>> getNewStation() async {
    return request<List<CoordinateStationModel>>(
      Method.get,
      AppApi.getRecommendStation,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) =>
                  CoordinateStationModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
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

  Future<BaseResp<dynamic>> getCountRent() async {
    return request<dynamic>(
      Method.get,
      AppApi.getCountRent,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
