
import 'package:connectivity_plus/connectivity_plus.dart';
import 'log_util.dart';

class NetworkUtil {
  static final Connectivity connectivity = Connectivity();

  static Future<bool> isConnected() async {
    try {
      final ConnectivityResult result = await connectivity.checkConnectivity();
      if (result != ConnectivityResult.none) {
        return true;
      }
      return false;
    } catch (e) {
      LogUtil.e("NetworkUtil exception: " + e.toString());
      return true;
    }
  }

  static Future<ConnectivityResult> get connectivityResult async {
    return connectivity.checkConnectivity();
  }

  static Stream<ConnectivityResult> get onConnectivityChanged => connectivity.onConnectivityChanged;
}
