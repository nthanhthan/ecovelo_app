// ignore_for_file: lines_longer_than_80_chars
class AppApi {
  static const String apiVer = "";
  //static resources
  //auth
  static const String login = "$apiVer/auth/login";
  static const String signUp = "$apiVer/auth/register";
  //station
  static const String getListStation = "$apiVer/station/getStation";
  //QR
  static const String checkQR = "$apiVer/bicycle/checkQR";
}
