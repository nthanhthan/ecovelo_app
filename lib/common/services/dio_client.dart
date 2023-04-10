// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../common.dart';

class Method {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  static const String head = "HEAD";
  static const String delete = "DELETE";
  static const String patch = "PATCH";
}

class DioClient {
  static final Dio _myDio = Dio(getDefOptions());
  static bool _isDebug = false;
  static HttpConfig _httpConfig = HttpConfigDefault();
  static ErrorMessageDelegate errorText = ErrorMessageDelegateDefault();
  static String Function(dynamic) onErrorHandle = (dynamic responseData) {
    if (responseData == null || responseData is! Map<String, dynamic>) {
      return errorText.somethingWentWrong;
    }
    return responseData['error'].toString();
  };

  /// get Def Options.
  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.contentType = ContentType.parse("application/json").toString();
    options.connectTimeout = 1000 * 14;
    options.receiveTimeout = 1000 * 12;
    return options;
  }

  static HttpConfig getConf() {
    return _httpConfig;
  }

  static void setConf(HttpConfig config) {
    _httpConfig = config;
  }

  static void setClientAdapter(Dio dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        LogUtil.d("X509Certificate: port: $port, host: $host, cer: $cert");
        return true;
      };
      return client;
    };
  }

  static void updateBaseUrl(Dio dio, Uri uri) {
    dio.options.baseUrl = uri.toString();
    LogUtil.d("updateBaseUrl: " + dio.options.baseUrl);
    setClientAdapter(dio);
  }

  static void updateTimeOut(Dio dio,
      {int connectTimeOut = 12000, int receiveTimeout = 9000}) {
    dio.options.connectTimeout = connectTimeOut;
    dio.options.receiveTimeout = receiveTimeout;
  }

  static void updateHeader(Dio dio, Map<String, String> headers) {
    Map<String, dynamic> curHeaders = dio.options.headers;
    headers.forEach((key, value) {
      curHeaders[key] = value;
    });
    dio.options.headers = curHeaders;
  }

  static void setCookie(Dio dio, String cookie) {
    Map<String, dynamic> headers = <String, dynamic>{};
    headers["Cookie"] = cookie;
    dio.options.headers.addAll(headers);
  }

  /// Enable debug
  static void setDebugMode(bool isEnabled) {
    _isDebug = isEnabled;
  }

  /// Decode response data.
  static Map<String, dynamic> decodeData(Response? response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return <String, dynamic>{};
    }
    return json.decode(response.data.toString()) as Map<String, dynamic>;
  }

  /// print Http Log.
  static void printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      LogUtil.d("----------------Http Log----------------"
              "\n[statusCode]:\t" +
          response.statusCode.toString() +
          "\n[request]:\t" +
          _getOptionsStr(response.requestOptions) +
          "\n[response]:\t" +
          response.data.toString() +
          "\n----------------End Log----------------");
    } catch (ex) {
      LogUtil.e("Http Log  error......");
    }
  }

  /// get Options Str.
  static String _getOptionsStr(RequestOptions request) {
    return "method: " +
        request.method +
        "  baseUrl: " +
        request.baseUrl +
        "  path: " +
        request.path;
  }

  static void clearInterceptors(Dio dio) {
    dio.interceptors.clear();
  }

  static void setInterceptorRefreshToken({
    required Dio dio,
    required Future<RefreshTokenRes<String>> Function() refreshToken,
    void Function()? cancelRefeshHandle,
    void Function()? failRefeshHandle,
  }) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError error, handler) async {
          // Do something with response error
          if (error.response?.statusCode == 401) {
            // // update token and repeat
            // // Lock to block the incoming request until the token updated
            //dio.lock();
            dio.interceptors.requestLock.lock();
            dio.interceptors.responseLock.lock();
            dio.interceptors.errorLock.lock();
            RequestOptions requestOptions = error.response!.requestOptions;
            RefreshTokenRes<String> refreshTokenRes = await refreshToken();
            switch (refreshTokenRes.status) {
              case RefreshTokenStatus.success:
                var options = Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                  sendTimeout: requestOptions.sendTimeout,
                  receiveTimeout: requestOptions.receiveTimeout,
                );
                if (refreshTokenRes.data != null &&
                    refreshTokenRes.data!.isNotEmpty) {
                  refreshTokenRes.authorizationHeader
                      ?.forEach((key, dynamic value) {
                    options.headers![key] = value;
                  });
                }
                _unLockInterceptors(dio);
                try {
                  final res = await dio.request<dynamic>(
                    requestOptions.path,
                    data: requestOptions.data,
                    queryParameters: requestOptions.queryParameters,
                    options: options,
                  );
                  handler.resolve(res);
                } on DioError catch (error) {
                  handler.next(error); // or handler.reject(error);
                }
                break;
              case RefreshTokenStatus.failed:
                _unLockInterceptors(dio);
                handler.reject(error);
                failRefeshHandle?.call();
                break;
              case RefreshTokenStatus.cancel:
                _unLockInterceptors(dio);
                handler.reject(error);
                cancelRefeshHandle?.call();
                break;
            }
          } else {
            handler.reject(error);
          }
        },
      ),
    );
  }

  static void _unLockInterceptors(Dio dio) {
    //dio.unlock();
    dio.interceptors.requestLock.unlock();
    dio.interceptors.responseLock.unlock();
    dio.interceptors.errorLock.unlock();
  }

  static void setInterceptorRetry(
    Dio dio, {
    int retries = 3,
    List<Duration> retryDelays = const [
      Duration(seconds: 1),
      Duration(seconds: 3),
      Duration(seconds: 5)
    ],
  }) {
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: (log) => LogUtil.d("RetryInterceptor: " + log),
      retries: retries,
      retryDelays: retryDelays,
      retryEvaluator: DefaultRetryEvaluator(const {
        status408RequestTimeout,
        status429TooManyRequests,
        status504GatewayTimeout,
        status440LoginTimeout,
        status499ClientClosedRequest,
        status460ClientClosedRequest,
        status522ConnectionTimedOut,
        status524TimeoutOccurred,
      }).evaluate,
    ));
  }

  static void setInterceptorLogger(Dio dio,
      {bool? printOnSuccess, bool convertFormData = true}) {
    dio.interceptors.add(LoggerDioInterceptor(
      printOnSuccess: printOnSuccess,
      convertFormData: convertFormData,
    ));
  }

  //Get dio
  static Dio currentDio() {
    return _myDio;
  }

  //Create dio builder
  static Dio createDio() {
    var newDio = Dio(getDefOptions());
    setClientAdapter(newDio);
    return newDio;
  }

  //clone Dio from
  static Dio cloneDio({Dio? dio}) {
    Dio source = dio ?? currentDio();
    var newDio = Dio(source.options.copyWith());
    setClientAdapter(newDio);
    return newDio;
  }

  // Nothing to do with your question, just a simple helper method to parse Dio exceptions:
  static String getUserExceptionMessage(DioError dioError) {
    return '${dioError.response!.statusCode}: ${dioError.response!.statusMessage}.\nURL: ${dioError.requestOptions.path}';
  }

  static MediaType? getMediaType(String filePath) {
    if (filePath.isImage()) {
      return MediaType("image", filePath.split('.').last);
    } else if (filePath.isPdf()) {
      return MediaType("application", filePath.split('.').last);
    }
    return null;
  }
}
