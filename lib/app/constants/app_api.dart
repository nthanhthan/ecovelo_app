// ignore_for_file: lines_longer_than_80_chars
class AppApi {
  static const String apiVer = "";
  //static resources
  //auth
  static const String login = "$apiVer/auth/login";
  static const String signUp = "$apiVer/auth/register";
  static const String refreshToken = "$apiVer/auth/refresh-token";
  static const String logout = "$apiVer/auth/logout";
  static const String checkPointUser = "$apiVer/auth/checkPoint";
  static const String getUser = "$apiVer/auth/getUser";
  static const String verifyAccount = "$apiVer/auth/verify";
  //station
  static const String getListStation = "$apiVer/station/getStation";
  //QR
  static const String checkQR = "$apiVer/bicycle/checkQR";
  static const String checkQRReport = "$apiVer/bicycle/check-report";
  //bicycle
  static const String rentBicycle = "$apiVer/bicycle/rent-bicycle";
  static const String stopRentBicycle = "$apiVer/bicycle/stop-rent";
  static const String reportProblem = "$apiVer/bicycle/report-problem";
  //trip
  static const String sendTrip = "$apiVer/trip/addTripDetail";
  static const String getListTrip = "$apiVer/trip/getListTrip";
  //add money
  static const String addMoney = "$apiVer/auth/addMoney";
  static const String getHistory = "$apiVer/transaction/getTransaction";
}
