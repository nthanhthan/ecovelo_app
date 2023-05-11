import 'package:ecoveloapp/app/core.dart';

class RentHttpService extends BaseApiClient {
  Future<BaseResp<int>> rentBicycle(String bicycleID) async {
    return request<int>(
      Method.post,
      AppApi.rentBicycle,
      data: bicycleID,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is int) {
          return jsonValue;
        } else {
          return null;
        }
      },
    );
  }
    Future<BaseResp<double>> stopRentBicycle(String bicycleID, int idRent) async {
    return request<double>(
      Method.post,
      AppApi.stopRentBicycle,
         data: {
        "rentID": idRent,
        "bicycleID": bicycleID,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is double) {
          return jsonValue;
        } else {
          return null;
        }
      },
    );
  }
}
