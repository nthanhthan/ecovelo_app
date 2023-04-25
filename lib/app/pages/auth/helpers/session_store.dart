import 'package:ecoveloapp/app/core.dart';

class SessionStore {
  LoginResp? getSession() {
    String token =
        Prefs.getString(SessionStoreKey.accessTokenKey, defaultValue: "");
    if (token.isEmpty) {
      return null;
    }
    LoginResp session = LoginResp(
      accessToken: token,
      refreshToken: Prefs.getString(SessionStoreKey.refreshTokenKey),
      expired: Prefs.getInt(SessionStoreKey.expireAt),
    );
    return session;
  }

  Future<void> save(LoginResp session) async {
    await Prefs.saveString(SessionStoreKey.accessTokenKey, session.accessToken);
    await Prefs.saveString(
        SessionStoreKey.refreshTokenKey, session.refreshToken);
    await Prefs.saveInt(SessionStoreKey.expireAt, session.expired);
  }

  Future<void> clear() async {
    await Prefs.removeKey(SessionStoreKey.accessTokenKey);
    await Prefs.removeKey(SessionStoreKey.refreshTokenKey);
    await Prefs.removeKey(SessionStoreKey.expireAt);
  }
}

class SessionStoreKey {
  static const String accessTokenKey = "ACCESS_TOKEN_KEY";
  static const String refreshTokenKey = "REFRESH_TOKEN_KEY";
  static const String expireAt = "EXPIRATION_KEY";
  static const String userIdKey = "USER_ID_KEY";
  static const String userEmailKey = "USER_EMAIL_KEY";
  static const String userFirstNameKey = "USER_FIRST_NAME_KEY";
  static const String userLastNameKey = "USER_LAS_NAME_KEY";
}
