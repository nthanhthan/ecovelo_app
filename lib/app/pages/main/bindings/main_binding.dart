import 'package:ecoveloapp/app/core.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    var loginCatchService = Get.put(LoginCacheService());
    Get.put(LoginManager(loginCacheService: loginCatchService));
    Get.put<AuthHttpService>(AuthHttpService());
    Get.put(MainController());
  }
}
