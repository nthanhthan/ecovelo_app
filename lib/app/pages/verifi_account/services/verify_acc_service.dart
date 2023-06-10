import 'package:ecoveloapp/app/core.dart';

class VerifyAccountService extends BaseApiClient {
  Future<BaseResp<bool>> verifyAccount(
      VerifyReq verifyReq) async {
    return request<bool>(
      Method.post,
      AppApi.verifyAccount,
      data: verifyReq.toJson(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
