import 'package:collection/collection.dart';

class EnumUtil {
  ///Enum to String
  static String enumValueToString(Object o) => o.toString().split('.').last;

  ///String to Enum
  static T? enumValueFromString<T>(String key, List<T?> values) => values.firstWhereOrNull((v) => key == enumValueToString(v!));
}
