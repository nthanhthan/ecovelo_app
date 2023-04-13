import 'package:ecoveloapp/app/core.dart';

class RentBicycleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RentBicycleController>(RentBicycleController());
  }
}
