import 'dart:convert';
import 'package:dio/dio.dart';

import '../utils/log_util.dart';

class LoggerDioInterceptor extends Interceptor {
  final bool? printOnSuccess;
  final bool convertFormData;

  LoggerDioInterceptor({this.printOnSuccess, this.convertFormData = true});

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _renderCurlRepresentation(err.requestOptions);

    return handler.next(err); //continue
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (printOnSuccess != null && printOnSuccess == true) {
      _renderCurlRepresentation(response.requestOptions);
    }

    return handler.next(response); //continue
  }

  void _renderCurlRepresentation(RequestOptions requestOptions) {
    // add a breakpoint here so all errors can break
    try {
      LogUtil.d('\t---------------CURL----------------\n' +
          _cURLRepresentation(requestOptions) +
          '\n\t---------------CURL-END----------------');
    } catch (err) {
      LogUtil.e('unable to create a CURL representation of the requestOptions');
    }
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = [];
    components.add('curl --location --request ${options.method} "${options.uri.toString()}"');
    options.headers.forEach((String k, dynamic v) {
      if (k != 'Cookie') {
        components.add('--header "$k: $v"');
      }
    });

    if (options.data != null) {
      // FormData can't be JSON-serialized, so keep only their fields attributes
      if (options.data is FormData && convertFormData == true) {
        options.data = Map<String, dynamic>.fromEntries(
            options.data.fields as Iterable<MapEntry<String, dynamic>>);
      }

      final data = json.encode(options.data).replaceAll('"', '\\"');
      components.add('--data "$data"');
    }

    return components.join(' \\\n\t');
  }
}
