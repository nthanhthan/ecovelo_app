import 'package:ecoveloapp/app/core.dart';

class JourneyService extends BaseApiClient {
  Future<BaseResp<List<DetailJouneyModel>>> getListTrip() async {
    return request<List<DetailJouneyModel>>(
      Method.get,
      AppApi.getListTrip,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => DetailJouneyModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
