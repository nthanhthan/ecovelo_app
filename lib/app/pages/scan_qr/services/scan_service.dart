import 'package:ecoveloapp/app/core.dart';

class ScanHttpService extends BaseApiClient {
  Future<BaseResp<dynamic>> checkQR(String id) async {
    return request<bool>(
      Method.post,
      AppApi.checkQR,
      data: id,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is bool) {
          return jsonValue;
        } else {
          return null;
        }
      },
    );
  }
}
