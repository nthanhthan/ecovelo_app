import 'package:ecoveloapp/app/core.dart';

class EcoUserController extends GetxController {
  late EcoUserService ecoUserService;

  int authencated = 0;
  int unauthencated = 0;
  int processing = 0;

  List<EcoUserModel>? listEcoUser;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  EcoUserModel? ecoUserModel;
  @override
  void onInit() {
    ecoUserService = Get.find<EcoUserService>();

    super.onInit();
  }

  Future<void> getAllUser() async {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    final res = await ecoUserService.getAllUser();
    if (res.isSuccess() && res.data != null) {
      listEcoUser = res.data;
    }
    getCountAuthencation();
    processingDialog.hide();
  }

  @override
  void onReady() {
    getAllUser().then((value) {
      isLoading = true;
    });
    super.onReady();
  }

  void getCountAuthencation() {
    if (listEcoUser != null && listEcoUser!.isNotEmpty) {
      for (var e in listEcoUser!) {
        if (e.getTypeAuthencation() == TypeAuthencation.authencated) {
          authencated += 1;
        } else if (e.getTypeAuthencation() == TypeAuthencation.unAuthencated) {
          unauthencated += 1;
        } else {
          processing += 1;
        }
      }
    }
  }
}
