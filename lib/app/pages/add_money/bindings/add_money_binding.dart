
import 'package:ecoveloapp/app/core.dart';

class AddMoneyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AddMoneyService>(AddMoneyService());
    Get.put<AddMoneyController>(AddMoneyController());
  }

}