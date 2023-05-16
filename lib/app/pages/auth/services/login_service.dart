import 'package:ecoveloapp/app/core.dart';

class LoginCacheService extends CacheServiceInterface {
  final repo = LoginRepo();
  final userRepo = UserRepo();
  @override
  Future<void> initRepos() async {
    if (!Hive.isBoxOpen(ModelTypeDefine.loginBox)) {
      await Hive.openBox<LoginResp>(ModelTypeDefine.loginBox);
    }
    await userRepo.init();
    await repo.init();
  }

  @override
  void registerTypeAdapters() {
    if (!Hive.isAdapterRegistered(ModelTypeDefine.user)) {
      Hive.registerAdapter<UserModel>(UserModelAdapter());
    }

    if (!Hive.isAdapterRegistered(ModelTypeDefine.login)) {
      Hive.registerAdapter<LoginResp>(LoginRespAdapter());
    }
  }

  @override
  Future<void> dispose() async {
    await repo.dispose();
    await userRepo.dispose();
    return super.dispose();
  }
}
