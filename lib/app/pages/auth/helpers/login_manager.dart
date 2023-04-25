import 'package:ecoveloapp/app/core.dart';

class LoginManager {
  LoginCacheService loginCacheService;

  LoginManager({required this.loginCacheService});

  Future<bool> initSession() async {
    await loginCacheService.init();
    return true;
  }

  LoginResp? getUser() {
    var data = loginCacheService.repo.getAllValues();
    if (data.isEmpty) return null;
    return data.values.first;
  }

  Future<void> saveUser(LoginResp? login) async {
    if (login == null) return;
    await loginCacheService.repo.putAndUpdateExisting(
      AppKeys.loginKey,
      login,
      (key, mutateMe, newValueReadOnly) {
        return newValueReadOnly;
      },
    );
  }

  Future<void> deleteUser() async {
    await loginCacheService.repo.deleteKeys([AppKeys.loginKey]);
  }
}
