import 'package:ecoveloapp/app/core.dart';
import 'package:intl/intl.dart';


  
class RevenueController extends GetxController {
   final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
  
  String parseMoney(double? money) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(money ?? 0);
  }
}
