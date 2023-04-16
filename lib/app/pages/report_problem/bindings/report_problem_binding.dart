import 'package:ecoveloapp/app/core.dart';

class ReportProblemBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReportProblemController>(ReportProblemController());
  }
}
