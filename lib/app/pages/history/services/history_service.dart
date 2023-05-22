import 'package:ecoveloapp/app/core.dart';

class HistoryService extends BaseApiClient {
  Future<BaseResp<List<HistoryModel>>> getHistory() async {
    return request<List<HistoryModel>>(
      Method.get,
      AppApi.getHistory,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => HistoryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
