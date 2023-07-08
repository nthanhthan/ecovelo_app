import 'package:ecoveloapp/app/core.dart';

class EcoUserService extends BaseApiClient {
  Future<BaseResp<dynamic>> getAllUser() async {
    return request<List<EcoUserModel>>(
      Method.get,
      AppApi.getAllUser,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((e) => EcoUserModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> getDetailUser(int idUser) async {
    return request<EcoUserModel>(
      Method.get,
      AppApi.getDetailUser(idUser),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return EcoUserModel.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> confimAuthencation(int idUser) async {
    return request<dynamic>(
      Method.get,
      AppApi.cofimAuthencation(idUser),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
