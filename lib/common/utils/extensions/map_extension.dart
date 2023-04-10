import 'dart:convert';
extension MapParsing on Map<dynamic, dynamic> {
  double? getDouble(dynamic key) {
    if (this[key] == null) {
      return null;
    }
    if (this[key] is int) {
      return (this[key] as int).toDouble();
    }
    if (this[key] is double) {
      return (this[key] as double);
    }
    if (this[key] is String) {
      return double.tryParse((this[key] as String));
    }
    return null;
  }

  int? getInt(dynamic key) {
    if (this[key] == null) {
      return null;
    }
    if (this[key] is int) {
      return (this[key] as int);
    }
    if (this[key] is String) {
      return int.tryParse((this[key] as String));
    }
    return null;
  }

  String? getString(dynamic key) {
    if (this[key] == null) {
      return null;
    }
    if (this[key] is String) {
      return (this[key] as String);
    }
    return this[key].toString();
  }

  bool? getBool(dynamic key) {
    if(this[key] == null) {
      return null;
    }
    if(this[key] is bool) {
      return this[key] as bool;
    }
    if(this[key] is int) {
      return this[key] == 1 ? true : false;
    }
    return null;
  }

  DateTime? getDateTimeFormString(dynamic key) {
    if (this[key] == null) {
      return null;
    }
    if (this[key] is String) {
      String dateStr = this[key] as String;
      return DateTime.tryParse(dateStr);
    }
    return null;
  }

  DateTime? getDateTimeFormTimestamp(dynamic key, {bool isMiliSecond = false}) {
    if (this[key] == null) {
      return null;
    }
    if (this[key] is int) {
      int timestamp = this[key] as int;
      if (!isMiliSecond) {
        timestamp = timestamp * 1000;
      }
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }

  List<T>? getList<T>(dynamic key) {
    if (this[key] == null) {
      return null;
    }
    if (this[key] is List<T>) {
      return (this[key] as List<T>);
    }
    return null;
  }

  T? getObject<T>(dynamic key, {required T Function(Map<String, dynamic>) onDeserialize}) {
    if (this[key] == null) {
      return null;
    }
    if (this[key] is Map<String, dynamic>) {
      return onDeserialize(this[key] as Map<String, dynamic>);
    }
    return null;
  }

  String get encodeObj => json.encode(this);
}
