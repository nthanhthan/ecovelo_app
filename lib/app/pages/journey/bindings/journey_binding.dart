import 'package:ecoveloapp/app/core.dart';

class JourneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<JourneyConroller>(JourneyConroller());
  }
}
