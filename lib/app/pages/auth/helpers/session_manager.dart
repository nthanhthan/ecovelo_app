import 'package:ecoveloapp/app/core.dart';

class SessionManager {
  LoginResp? session;
  final SessionStore store;
  final AuthHttpService authService;

  SessionManager({required this.store, required this.authService});

  Future<bool> initSession(LoginResp session) async {
    //
    await saveSession(session);
    DioClient.updateHeader(
      DioClient.currentDio(),
      {
        "Authorization": "Bearer ${session.accessToken}",
      },
    );
    // DioClient.setInterceptorsRefreshToken(DioClient.currentDio(), () async {
    //   var result = await renewSession();
    //   return result?.accessToken ?? "";
    // });
    //update session info from User Info
    return true;
  }

  Future<void> saveSession(LoginResp? session) async {
    this.session = session;
    if (session != null) {
      await store.save(session);
    }
  }

  void loadSession() {
    session = store.getSession();
  }

  bool hasSession() {
    if (session == null) loadSession();
    return session != null;
  }

  bool hasSessionExpired() {
    //5-minute clock skew. offset for pre renew token
    // var skewSeconds = 60 * 5;
    int currentMillis = DateTime.now().millisecondsSinceEpoch;
    int valueToCompare = session?.expired ?? 0;
    return hasSession() && currentMillis > valueToCompare;
  }

  // Future<LoginResp?> renewSession() async {
  //   if (hasSession()) {
  //     BaseRespR<LoginResp> resp = await authService.refreshToken(session?.refreshToken ?? "");
  //     if (resp.isSuccess() && resp.data != null) {
  //       session?.accessToken = resp.data!.token ?? "";
  //       session?.expireAt = resp.data!.expireAt ?? 0;
  //       session?.refreshToken = resp.data!.refreshToken ?? "";
  //       await saveSession(session);
  //       //setup header for service
  //       DioClient.updateHeader(
  //         DioClient.currentDio(),
  //         {
  //           "Authorization": "Bearer ${session?.accessToken}",
  //         },
  //       );
  //       return session;
  //     } else {
  //       //handle user account invalid for refresh token
  //       if (resp.statusCode == 404 || resp.statusCode == 400) {
  //         await cleanSession();
  //         DioClient.currentDio().clear();
  //         Get.offAllNamed<void>(Routes.login);
  //       }
  //     }
  //   }
  //   return null;
  // }

  Future<bool> cleanSession() async {
    await HiveManager.clearAllData();
    if (hasSession()) {
      session = null;
      await store.clear();
      DioClient.updateHeader(
        DioClient.currentDio(),
        {
          "Authorization": "",
        },
      );
      DioClient.clearInterceptors(DioClient.currentDio());
      return true;
    } else {
      return true;
    }
  }
}
