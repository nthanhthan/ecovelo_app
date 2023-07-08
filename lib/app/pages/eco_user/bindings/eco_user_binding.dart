import 'package:ecoveloapp/app/core.dart';

class EcoUseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EcoUserService>(EcoUserService());
    Get.put<EcoUserController>(EcoUserController());
  }
}
