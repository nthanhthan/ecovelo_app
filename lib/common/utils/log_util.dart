import 'dart:developer';
import 'dart:io';
import 'package:f_logs/f_logs.dart';

/// Log Util.
class LogUtil {
  static const String _defTag = 'common';
  static bool _debugMode = false;
  static int _maxLen = 2048;
  static String _tagValue = _defTag;
  static bool _isUsingFlog = true;

  static void init({
    String tag = _defTag,
    bool isDebug = false,
    int maxLen = 2048,
    bool isUsingFlog = true,
  }) {
    _tagValue = tag;
    _debugMode = isDebug;
    _maxLen = maxLen;
    _isUsingFlog = isUsingFlog;
    if (_isUsingFlog) {
      _initFlog();
    }
  }

  static void _initFlog() {
    LogsConfig config = FLog.getDefaultConfigurations()
      ..isDevelopmentDebuggingEnabled = false
      ..isDebuggable = false
      ..timestampFormat = TimestampFormat.TIME_FORMAT_SIMPLE
      ..formatType = FormatType.FORMAT_CUSTOM
      ..fieldOrderFormatCustom = [
        FieldName.TIMESTAMP,
        FieldName.CLASSNAME,
        FieldName.METHOD_NAME,
        FieldName.TEXT,
        FieldName.EXCEPTION,
        FieldName.STACKTRACE
      ]
      ..customOpeningDivider = "{"
      ..customClosingDivider = "}";

    FLog.applyConfigurations(config);
    FLog.clearLogs();
    FLog.info(text: "=======Start App======");
  }

  static Future<File?> exportAllLogs() async {
    if (_isUsingFlog) {
      File file = await FLog.exportLogs();
      return file;
    } else {
      return null;
    }
  }

  static Future<void> deleteAllLogs() async {
    await FLog.clearLogs();
  }

  static void d(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag, ' d ', object);
    }
    if (_isUsingFlog) {
      String da = object.toString();
      FLog.info(text: da);
    }
  }

  static void e(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag, ' e ', object);
    }
    if (_isUsingFlog) {
      String da = object.toString();
      FLog.error(text: da);
    }
  }

  static void v(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag, ' v ', object);
    }
    if (_isUsingFlog) {
      String da = object.toString();
      FLog.warning(text: da);
    }
  }

  static void _printLog(String? tag, String? stag, Object? object) {
    String da = object?.toString() ?? 'null';
    if(da.length > _maxLen){
      da = da.substring(0, _maxLen) + '<…>';
    }
    tag = tag ?? _tagValue;
      log('$tag$stag $da');
      return;
    }
}
