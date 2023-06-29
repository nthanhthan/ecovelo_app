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
  static const String getRecommendStation = "http://192.168.1.6:8000/cluster-centers";
  static String getRecogetNearBy(lat,lng, radius,category,apiKey) => "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&type=$category&key=$apiKey";
  //QR
  static const String checkQR = "$apiVer/bicycle/checkQR";
  static const String checkQRReport = "$apiVer/bicycle/check-report";
  //bicycle
  static const String rentBicycle = "$apiVer/bicycle/rent-bicycle";
  static const String stopRentBicycle = "$apiVer/bicycle/stop-rent";
  static const String reportProblem = "$apiVer/bicycle/report-problem";
  static  String fallBicycle(idRent) => "$apiVer/bicycle/fallBicycle/$idRent";
  //trip
  static const String sendTrip = "$apiVer/trip/addTripDetail";
  static const String getListTrip = "$apiVer/trip/getListTrip";
  static const String feeadback = "$apiVer/bicycle/feedback";
  //add money
  static const String addMoney = "$apiVer/auth/addMoney";
  static const String getHistory = "$apiVer/transaction/getTransaction";

}
