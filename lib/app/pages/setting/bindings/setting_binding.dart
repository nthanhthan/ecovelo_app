import 'package:ecoveloapp/app/core.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingController>(SettingController());
  }
}
