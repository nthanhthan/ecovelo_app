import 'package:ecoveloapp/app/core.dart';

class StationHttpService extends BaseApiClient {
  Future<BaseResp<List<StationModel>>> getListStation() async {
    return request<List<StationModel>>(
      Method.get,
      AppApi.getListStation,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => StationModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
