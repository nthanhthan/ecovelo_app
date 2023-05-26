import 'package:ecoveloapp/app/core.dart';

class EnterCodeBinding extends Bindings {
  @override
  void dependencies() {
 
    Get.put<EnterCodeController>(EnterCodeController());
  }
}
