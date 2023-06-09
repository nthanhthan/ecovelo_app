import 'package:ecoveloapp/app/core.dart';

class VerifiAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VerifiAccountController>(VerifiAccountController());
  }
}
