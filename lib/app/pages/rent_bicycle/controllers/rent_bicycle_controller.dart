import 'package:ecoveloapp/app/core.dart';

class RentBicycleController extends GetxController {
  final RxBool _isMainWallet = true.obs;
  set isMainWallet(bool value) => _isMainWallet.value = value;
  bool get isMainWallet => _isMainWallet.value;

  final RxBool _isStart = false.obs;
  set isStart(bool value) => _isStart.value = value;
  bool get isStart => _isStart.value;

  late final RentHttpService _rentHttpService;

  late LoginManager _loginManager;

  UserModel? userModel;

  void changeWallet() {
    isMainWallet = !isMainWallet;
  }

  String bikeID = "";
  @override
  void onInit() {
    _rentHttpService = Get.find<RentHttpService>();
    _loginManager = Get.find<LoginManager>();
    userModel = _loginManager.getUser();
    if (Get.arguments != null && Get.arguments is String) {
      bikeID = Get.arguments as String;
    }
    super.onInit();
  }

  Future<bool> startRentBicycle() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final result = await _rentHttpService.rentBicycle(bikeID);
    MQTTClientWrapper newclient = MQTTClientWrapper();
    newclient.prepareMqttClient(bikeID);
    if (result.isSuccess() && result.data != null) {
      processingDialog.hide();
      if (result.data == -1) {
        return false;
      }
      Prefs.saveInt(AppKeys.rentID, result.data!);
      return true;
    }

    processingDialog.hide();
    return false;
  }
}
