import 'dart:convert';
abstract class BaseReq{
  Map<String, dynamic> toRequest();

  @override
  String toString() {
    return jsonEncode(this);
  }
}