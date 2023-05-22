import 'package:ecoveloapp/app/core.dart';

class HistoryController extends GetxController {
  late HistoryService _historyService;

  List<HistoryModel>? listHistories;

  Map<DateTime, List<HistoryModel>>? historyGroupDay;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _historyService = Get.find<HistoryService>();
    getHistory().then((value) {
      if (value) {
        isLoading = true;
      }
    });
    super.onInit();
  }

  Future<bool> getHistory() async {
    final result = await _historyService.getHistory();
    if (result.isSuccess() && result.data != null) {
      listHistories = result.data;
      groupRecordsByDay(listHistories);
    }
    return true;
  }

  bool groupRecordsByDay(List<HistoryModel>? historyModels) {
    historyGroupDay?.clear();
    Map<DateTime, List<HistoryModel>> groups = {};
    if (historyModels != null) {
      for (HistoryModel historyItem in historyModels) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
            historyItem.dateTimeTransaction ?? 0);

        DateTime day = DateTime(date.year, date.month, date.day);
        List<HistoryModel> group = groups[day] ?? [];

        group.add(historyItem);
        groups[day] = group;
      }
      historyGroupDay = groups;
      historyGroupDay?.forEach((key, value) {
        historyGroupDay![key] = value.reversed.toList();
      });
      Map<DateTime, List<HistoryModel>> reversedHistoryGroupDay = {};
      List<DateTime> keys = historyGroupDay!.keys.toList()
        ..sort((a, b) => b.compareTo(a));
      for (DateTime key in keys) {
        reversedHistoryGroupDay[key] = historyGroupDay![key]!;
      }
      historyGroupDay = reversedHistoryGroupDay;
      return true;
    }
    return false;
  }
}
