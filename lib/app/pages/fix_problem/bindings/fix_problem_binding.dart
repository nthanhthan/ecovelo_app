import 'package:ecoveloapp/app/core.dart';


class FixProblemBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FixProblemController>(FixProblemController());
  }
}
