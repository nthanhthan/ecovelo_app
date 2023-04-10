import 'package:intl/intl.dart';
class NumberUtil {
  static String formatNumber(dynamic value){
    return NumberFormat.compact().format(value);
  }
}
