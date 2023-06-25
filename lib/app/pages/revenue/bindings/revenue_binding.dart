import 'package:ecoveloapp/app/core.dart';

class RevenueBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RevenueController>(RevenueController());
  }
}
