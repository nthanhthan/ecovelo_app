import 'package:ecoveloapp/app/core.dart';
import 'package:ecoveloapp/app/pages/auth/controllers/signup_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
  }
}
