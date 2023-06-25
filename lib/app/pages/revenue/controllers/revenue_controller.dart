import 'package:ecoveloapp/app/core.dart';
import 'package:intl/intl.dart';

class RevenueController extends GetxController {
  String parseMoney(double? money) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(money ?? 0);
  }
}
