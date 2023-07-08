import 'package:ecoveloapp/app/core.dart';
import 'package:intl/intl.dart';

class EcoUserDetailController extends GetxController {
  final Rxn<EcoUserModel> _ecoUserModel = Rxn<EcoUserModel>();
  set ecoUserModel(EcoUserModel value) => _ecoUserModel.value = value;
  EcoUserModel? get getEcoUserModel => _ecoUserModel.value;

  late EcoUserService ecoUserService;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;
  int? userID;

  final RxInt _role = 1.obs;
  set role(int value) => _role.value = value;
  int get role => _role.value;

  int idRoleUser = 1;

  int authencated = 0;
  int unauthencated = 0;
  int processing = 0;

  void changeRole(int idRole) {
    role = idRole;
  }
  @override
  void onInit() {
    ecoUserService = Get.find<EcoUserService>();
    if (Get.arguments != null && Get.arguments is int) {
      userID = Get.arguments as int;
    }
    super.onInit();
  }

  @override
  void onReady() {
    getDetailUser(userID).then((value) {
      isLoading = true;
    });
    super.onReady();
  }

  String parseMoney(int? money) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(money ?? 0);
  }

  Future<bool> getDetailUser(int? userID) async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    if (userID != null) {
      final res = await ecoUserService.getDetailUser(userID);
      if (res.isSuccess() && res.data != null) {
        ecoUserModel = res.data;
        processingDialog.hide();
        return true;
      }
    }
    processingDialog.hide();
    return false;
  }

  Future<bool> confirmAuthencation() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    if (getEcoUserModel?.userModel?.userId != null) {
      final res = await ecoUserService
          .confimAuthencation(getEcoUserModel!.userModel!.userId!);
      if (res.isSuccess()) {
        processingDialog.hide();
        return true;
      }
    } else {
      processingDialog.hide();
      return false;
    }
    return false;
  }
}
