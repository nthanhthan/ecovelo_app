import 'package:ecoveloapp/app/core.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    var loginCatchService = Get.put(LoginCacheService());
    SessionStore ssStore = Get.put<SessionStore>(SessionStore());
    AuthHttpService authHttp = Get.put<AuthHttpService>(AuthHttpService());
    var sessionM = SessionManager(store: ssStore, authService: authHttp);
    Get.put<RentHttpService>(RentHttpService());
    Get.put<StripeService>(StripeService());
    Get.put<SessionManager>(sessionM);
    Get.put(LoginManager(loginCacheService: loginCatchService));
    Get.put<AuthHttpService>(AuthHttpService());
    Get.put(MainController());
  }
}
