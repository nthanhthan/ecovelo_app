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

  Future<BaseResp<dynamic>> logout() async {
    return request<dynamic>(
      Method.delete,
      AppApi.logout,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<LoginResp>> refreshToken(String refreshToken) async {
        return request<LoginResp>(
      Method.post,
      AppApi.refreshToken,
      data: {
      refreshToken
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
