import 'dart:convert';

abstract class BaseObject {
  BaseObject();

  @override
  String toString() {
    return jsonEncode(this);
  }
}
