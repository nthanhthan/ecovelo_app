import 'package:ecoveloapp/app/core.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StationHttpService>(StationHttpService());
    Get.put<MapController>(MapController());
    Get.put<HomeController>(HomeController());
    Get.put<NotificationController>(NotificationController());
    Get.put<SettingController>(SettingController());
  }
}
