import 'package:dio/dio.dart';
import '../common.dart';

class BaseResp<T> {
  T? data;
  String? errorMsg;
  int statusCode;
  Response? response;

  BaseResp({
    this.data,
    this.statusCode = -1,
    this.errorMsg = "",
    this.response,
  });

  factory BaseResp.dataFromJson({
    required dynamic json,
    required dynamic Function(dynamic) onDeserialize,
    int statusCode = -1,
    Response? response,
  }) {
    var resp = BaseResp<T>(
      response: response,
      statusCode: statusCode,
    );
    try {
      if (json is Map<String, dynamic>) {
        resp.data = onDeserialize(json) as T;
      } else if (json is List) {
        resp.data = onDeserialize(json) as T;
      } else if (T == bool ||
          T == String ||
          T == int ||
          T == double ||
          T == Map) {
        // primitives
        resp.data = json as T?;
      }
    } catch (error) {
      LogUtil.e(
          "${T.toString()} Data parsing exception...! => " + error.toString());
      resp.data = null;
      resp.errorMsg = error.toString();
      throw FormatException;
    }
    return resp;
  }

  factory BaseResp.withError({
    required String errorMsg,
    int statusCode = -1,
    Response? response,
  }) =>
      BaseResp(
        data: null,
        errorMsg: errorMsg,
        statusCode: statusCode,
        response: response,
      );

  factory BaseResp.withData({
    required T data,
    String errorMsg = "",
    int statusCode = -1,
    Response? response,
  }) =>
      BaseResp(
        data: data,
        errorMsg: errorMsg,
        statusCode: statusCode,
        response: response,
      );

  bool isSuccess() {
    return (errorMsg == null || errorMsg!.isEmpty) &&
        statusCode >= 200 &&
        statusCode < 300;
  }

  bool isHaveRespData() {
    return isSuccess() && data != null;
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"status\":\"$statusCode\"");
    sb.write(",\"msg\":\"$errorMsg\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}
