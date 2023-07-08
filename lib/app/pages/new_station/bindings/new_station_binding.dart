import 'package:ecoveloapp/app/core.dart';

class NewStationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewStationService>(NewStationService());
    Get.put<NewStationController>(NewStationController());
  }
}
