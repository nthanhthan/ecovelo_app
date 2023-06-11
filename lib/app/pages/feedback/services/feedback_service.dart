import 'package:ecoveloapp/app/core.dart';

class FeeadbackService extends BaseApiClient {
  Future<BaseResp<bool>> feedback(FeedbackRequest feedbackRequest) async {
    return request<bool>(
      Method.post,
      AppApi.feeadback,
      data: feedbackRequest.toJson(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
