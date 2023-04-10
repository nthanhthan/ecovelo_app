class ErrorMessageDelegateDefault extends ErrorMessageDelegate {
  ErrorMessageDelegateDefault();
}

abstract class ErrorMessageDelegate {
  String somethingWentWrong = 'Something went wrong';
  String noInternetConnection = 'No Internet connection';
  String requestTimeOut = 'Request timeout, Please check your connection';
  String sendTimeOut = 'Send timeout, Please check your connection';
  String unableToConnectTheServer = 'Unable to connect to the server';
  String couldNotFindTheRequest = "Couldn't find the request";
  String badResponseFormat = 'Bad response format';
}
