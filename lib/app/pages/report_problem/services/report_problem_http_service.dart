import 'package:ecoveloapp/app/core.dart';

class ReportProblemService extends BaseApiClient {
  Future<BaseResp<bool>> reportProblem(
      ReportProblemReq reportProblemReq) async {
    return request<bool>(
      Method.post,
      AppApi.reportProblem,
      data: reportProblemReq.toJson(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
