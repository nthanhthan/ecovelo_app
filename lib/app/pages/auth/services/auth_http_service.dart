import 'package:ecoveloapp/app/core.dart';

class AuthHttpService extends BaseApiClient {
  Future<BaseResp<dynamic>> login(
      {required String userName, required String password}) async {
    return request<LoginResp>(
      Method.post,
      AppApi.login,
      data: {
        "phoneNumber": userName,
        "password": password,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return LoginResp.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  // Future<BaseResp<dynamic>> logout() async {
  //   return request<dynamic>(
  //     Method.delete,
  //     AppApi.logout,
  //     onDeserialize: (dynamic jsonValue) {
  //       return jsonValue;
  //     },
  //   );
  // }

  // Future<BaseRespR<LoginResp>> refreshToken(String refreshToken) async {
  //   dio.Dio refreshTokenDio = dio.Dio();
  //   try {
  //     refreshTokenDio.options = service.options;
  //     var response = await refreshTokenDio.post<Map<String, dynamic>>(
  //       AppApi.refreshToken,
  //       data: {
  //         "refreshToken": refreshToken,
  //       },
  //     );
  //     if (response.data != null) {
  //       LoginResp resp = LoginResp.fromJson(response.data!);
  //       return BaseRespR<LoginResp>(data: resp, statusCode: response.statusCode!, response: response);
  //     } else {
  //       return BaseRespR.withError(statusCode: response.statusCode ?? -1, errorMsg: response.statusMessage ?? "Unknown error!");
  //     }
  //   } on dio.DioError catch (dioErr) {
  //     String errMessage = jsonEncode(dioErr.response?.data ?? "");
  //     if (errMessage.isEmpty) {
  //       errMessage = dioErr.message;
  //     }
  //     return BaseRespR.withError(
  //       statusCode: dioErr.response?.statusCode ?? (dioErr.type == dio.DioErrorType.connectTimeout ? 408 : -1),
  //       errorMsg: errMessage,
  //     );
  //   } catch (e) {
  //     return BaseRespR.withError(errorMsg: "errorMsg");
  //   }
  // }

  // Future<BaseResp<dynamic>> resetPassword(String email) async {
  //   return request<dynamic>(
  //     Method.post,
  //     AppApi.resetPassword,
  //     data: {
  //       "email": email,
  //     },
  //     onDeserialize: (dynamic jsonValue) {
  //       return jsonValue;
  //     },
  //   );
  // }

  // Future<BaseRespR<dynamic>> updatePassword(String token, String password) async {
  //   return requestR<dynamic>(
  //     Method.put,
  //     AppApi.resetPassword,
  //     data: {
  //       "token": token,
  //       "password": password,
  //     },
  //     onDeserialize: (dynamic jsonValue) {
  //       return jsonValue;
  //     },
  //   );
  // }

  // Future<BaseRespR<dynamic>> resetPasswordCheckToken(String token) async {
  //   return requestR<dynamic>(
  //     Method.post,
  //     AppApi.resetPasswordCheckToken,
  //     data: {
  //       "token": token,
  //     },
  //     onDeserialize: (dynamic jsonValue) {
  //       return jsonValue;
  //     },
  //   );
  // }

  Future<BaseResp<dynamic>> signUp(SignUpReq signUpReq) async {
    return request<dynamic>(
      Method.post,
      AppApi.signUp,
      data: signUpReq.toJson(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
