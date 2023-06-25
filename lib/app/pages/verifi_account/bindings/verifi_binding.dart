import 'package:ecoveloapp/app/core.dart';

class VerifiAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VerifyAccountService>(VerifyAccountService());
    Get.put<VerifiAccountController>(VerifiAccountController());
  }
}
