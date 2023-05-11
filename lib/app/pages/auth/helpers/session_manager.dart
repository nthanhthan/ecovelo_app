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
    DioClient.setInterceptorsRefreshToken(DioClient.currentDio(), () async {
      var result = await renewSession();
      return result?.accessToken ?? "";
    });
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

  Future<bool> hasSession() async {
    if (session == null) loadSession();
    if (session != null) {
      if (hasSessionExpired()) {
        return true;
      } else {
        await renewSession();
      }
    }
    return session != null;
  }

  bool hasSessionExpired() {
    int currentMillis = DateTime.now().millisecondsSinceEpoch;
    int valueToCompare = session?.expired ?? 0;
    return   currentMillis <= valueToCompare;
  }

  Future<LoginResp?> renewSession() async {
    final resp = await authService.refreshToken(session?.refreshToken ?? "");
    if (resp.isSuccess() && resp.data != null) {
      session?.accessToken = resp.data!.accessToken;
      session?.expired = resp.data!.expired;
      session?.refreshToken = resp.data!.refreshToken;
      await saveSession(session);
      //setup header for service
      DioClient.updateHeader(
        DioClient.currentDio(),
        {
          "Authorization": "Bearer ${session?.accessToken}",
        },
      );
      return session;
    } else {
      //handle user account invalid for refresh token
      await cleanSession();
      // ignore: deprecated_member_use
      DioClient.currentDio().clear();
      Get.offAllNamed<void>(Routes.signin);
    }
    return null;
  }

  Future<bool> cleanSession() async {
    await HiveManager.clearAllData();

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
  }
}
