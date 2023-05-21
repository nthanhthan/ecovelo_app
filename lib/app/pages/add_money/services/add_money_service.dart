import 'package:ecoveloapp/app/core.dart';

class AddMoneyService extends BaseApiClient {
  Future<BaseResp<TransactionResp>> addMoney(
      {required TransactionReq transactionReq}) async {
    return request<TransactionResp>(
      Method.post,
      AppApi.addMoney,
      data: transactionReq.toJson(),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return TransactionResp.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }
}
