import 'package:ecoveloapp/app/core.dart';


class AppApiError {
  static String errorMessageHandle(dynamic responseData) {
    String defaultErrorMessage = 'Something went wrong';
    if (responseData == null) {
      return defaultErrorMessage;
    }
    if (responseData is! Map<String, dynamic>) {
      return defaultErrorMessage;
    }
    if (responseData['errors'] != null) {
      try {
        String errMessage = ((responseData['errors'] as List).first
                as Map<String, dynamic>)['msg']
            .toString();
        return errMessage;
      } catch (e) {
        LogUtil.e('AppApiError: errors: $e');
      }
    }
    if (responseData['message'] != null) {
      try {
        String errMessage = responseData['message'].toString();
        return errMessage;
      } catch (e) {
        LogUtil.e('AppApiError: message: $e');
      }
    }
    if (responseData['detail'] != null) {
      try {
        String errMessage = responseData['detail'].toString();
        return errMessage;
      } catch (e) {
        LogUtil.e('AppApiError: detail: $e');
      }
    }
    return defaultErrorMessage;
  }
}
