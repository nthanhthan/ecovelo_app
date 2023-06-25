import 'package:ecoveloapp/app/core.dart';

class JourneyDetailBinding extends Bindings {
  @override
  void dependencies() {

    Get.put<JourneyDetailConroller>(JourneyDetailConroller());
  }
}
