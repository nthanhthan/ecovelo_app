
import 'package:ecoveloapp/app/core.dart';

class AddMoneyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AddMoneyController>(AddMoneyController());
  }

}