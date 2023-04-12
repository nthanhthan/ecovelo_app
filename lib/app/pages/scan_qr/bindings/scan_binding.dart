import 'package:ecoveloapp/app/core.dart';

class ScanBinding extends Bindings{
    @override
  void dependencies() {
    Get.put<ScanController>(ScanController());
   
  }
}