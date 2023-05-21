import 'package:ecoveloapp/app/core.dart';

class HistoryBingding extends Bindings {
  @override
  void dependencies() {
    Get.put<HistoryService>(HistoryService());
    Get.put<HistoryController>(HistoryController());
  }
}
