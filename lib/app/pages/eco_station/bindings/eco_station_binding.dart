import 'package:ecoveloapp/app/core.dart';

class EcoStationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EcoStationController>(EcoStationController());
  }
}
