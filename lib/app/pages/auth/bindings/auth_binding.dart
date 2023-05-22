import 'package:ecoveloapp/app/core.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
  }
}
