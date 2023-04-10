import 'package:dio/dio.dart';

class HttpConfigDefault extends HttpConfig {
  HttpConfigDefault()
      : super(
          status: "status",
          code: "errorCode",
          msg: "errorMsg",
          data: "data",
          options: BaseOptions(),
        );
}

abstract class HttpConfig {
  /// constructor.
  HttpConfig({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
    required this.options,
  });

  /// BaseResp [String status] Field: key, def：status.
  String status;

  /// BaseResp [int code]Field key, def：errorCode.
  String code;

  /// BaseResp [String msg]Field key, def：errorMsg.
  String msg;

  /// BaseResp [T data]Field key, def：data.
  String data;

  /// Options.
  BaseOptions options;
}
