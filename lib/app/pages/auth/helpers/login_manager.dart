import 'package:ecoveloapp/app/core.dart';

class LoginManager {
  LoginCacheService loginCacheService;

  LoginManager({required this.loginCacheService});

  Future<bool> initSession() async {
    await loginCacheService.init();
    return true;
  }

  LoginResp? getLogin() {
    var data = loginCacheService.repo.getAllValues();
    if (data.isEmpty) return null;
    return data.values.first;
  }

  UserModel? getUser() {
    var data = loginCacheService.userRepo.getAllValues();
    if (data.isEmpty) return null;
    return data.values.first;
  }

  Future<void> saveLogin(LoginResp? login) async {
    if (login == null) return;
    await loginCacheService.repo.putAndUpdateExisting(
      AppKeys.loginKey,
      login,
      (key, mutateMe, newValueReadOnly) {
        return newValueReadOnly;
      },
    );
  }

  Future<void> saveUser(UserModel? user) async {
    if (user == null) return;
    await loginCacheService.userRepo.putAndUpdateExisting(
      AppKeys.userKey,
      user,
      (key, mutateMe, newValueReadOnly) {
        return newValueReadOnly;
      },
    );
  }

  Future<void> deleteUser() async {
    await loginCacheService.repo.deleteKeys([AppKeys.loginKey]);
  }
}
