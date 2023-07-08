import 'package:ecoveloapp/app/core.dart';

class EcoUseDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EcoUserDetailController>(EcoUserDetailController());
  }
}
