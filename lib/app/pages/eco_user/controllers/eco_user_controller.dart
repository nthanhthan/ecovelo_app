import 'package:ecoveloapp/app/core.dart';

class EcoUserController extends GetxController {
  final RxInt _role = 1.obs;
  set role(int value) => _role.value = value;
  int get role => _role.value;

  int idRoleUser = 1;

  void changeRole(int idRole) {
    role = idRole;
  }
}
