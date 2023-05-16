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
    Future<BaseResp<UserModel>> stopRentBicycle(String bicycleID, int idRent) async {
    return request<UserModel>(
      Method.post,
      AppApi.stopRentBicycle,
         data: {
        "rentID": idRent,
        "bicycleID": bicycleID,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
           return UserModel.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }
}
