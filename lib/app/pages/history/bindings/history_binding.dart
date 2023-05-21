import 'package:ecoveloapp/app/core.dart';

class HistoryBingding extends Bindings {
  @override
  void dependencies() {
    Get.put<HistoryController>(HistoryController());
  }
}
