import 'package:ecoveloapp/app/core.dart';
import 'package:intl/intl.dart';

class TransferSuccessController extends GetxController {
  late TransactionResp transactionResp;

  late DateTime _dateTime;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is TransactionResp) {
      transactionResp = Get.arguments as TransactionResp;
      _dateTime = getDateTime();
    }
    super.onInit();
  }

  String getMoney() {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(transactionResp.point ?? 0);
  }

  DateTime getDateTime() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        transactionResp.dateTimeTransaction ?? 0);
    return dateTime;
  }

  String getTime() {
    return "${_dateTime.hour}:${_dateTime.minute}:${_dateTime.second}";
  }

  String getDate() {
    return "${_dateTime.day}-${DateFormat('MMMM').format(_dateTime)}-${_dateTime.year}";
  }
}
