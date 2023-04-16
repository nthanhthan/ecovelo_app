import 'package:ecoveloapp/app/core.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<MapController>(MapController());
    Get.put<NotificationController>(NotificationController());
    Get.put<SettingController>(SettingController());
  }
}
