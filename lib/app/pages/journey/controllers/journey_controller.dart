import 'package:ecoveloapp/app/core.dart';

class JourneyConroller extends GetxController {
  List<DetailJouneyModel>? listJourney;
  Map<DateTime, List<DetailJouneyModel>>? historyGroupDay;

  final RxDouble _totalDistance = 0.0.obs;
  double get totalDistance => _totalDistance.value;
  final RxDouble _totalTime = 0.0.obs;
  double get totalTime => _totalTime.value;
  final RxDouble _totalEnergy = 0.0.obs;
  double get totalEnergy => _totalEnergy.value;
  final RxDouble _totalCardbon = 0.0.obs;
  double get totalCardbon => _totalCardbon.value;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    getListTrip().then((value) {
      if (value == true) {
        isLoading = true;
      }
    });
    super.onInit();
  }

  Future<bool> getListTrip() async {
    final result = await JourneyService().getListTrip();
    if (result.isSuccess() && result.data != null) {
      listJourney = result.data!;
      caculateInfo();
      groupRecordsByDay(listJourney);
    }
    return true;
  }

  bool groupRecordsByDay(List<DetailJouneyModel>? historyModels) {
    historyGroupDay?.clear();
    Map<DateTime, List<DetailJouneyModel>> groups = {};
    if (historyModels != null) {
      for (DetailJouneyModel historyItem in historyModels) {
        DateTime date =
            DateTime.fromMillisecondsSinceEpoch(historyItem.beginTimeRent ?? 0);

        DateTime day = DateTime(date.year, date.month, date.day);
        List<DetailJouneyModel> group = groups[day] ?? [];

        group.add(historyItem);
        groups[day] = group;
      }
      historyGroupDay = groups;
      historyGroupDay?.forEach((key, value) {
        historyGroupDay![key] = value.reversed.toList();
      });
      Map<DateTime, List<DetailJouneyModel>> reversedHistoryGroupDay = {};
      List<DateTime> keys = historyGroupDay!.keys.toList()
        ..sort((a, b) => b.compareTo(a));
      for (DateTime key in keys) {
        reversedHistoryGroupDay[key] = historyGroupDay![key]!;
      }
      historyGroupDay?.clear();
      historyGroupDay = reversedHistoryGroupDay;
      return true;
    }
    return false;
  }

  void caculateInfo() {
    listJourney?.forEach((e) {
      _totalDistance.value += e.distance!;
      _totalTime.value += e.totalTime!;
      _totalEnergy.value += e.energy!;
    });
  }
}
