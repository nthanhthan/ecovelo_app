import 'package:ecoveloapp/app/core.dart';

class RentBicycleController extends GetxController {
  final RxBool _isMainWallet = true.obs;
  set isMainWallet(bool value) => _isMainWallet.value = value;
  bool get isMainWallet => _isMainWallet.value;

  final RxBool _isStart = false.obs;
  set isStart(bool value) => _isStart.value = value;
  bool get isStart => _isStart.value;

  void changeWallet() {
    isMainWallet = !isMainWallet;
  }

  void startRent() {
    isStart = true;
  }
}
