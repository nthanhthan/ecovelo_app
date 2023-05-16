import 'package:ecoveloapp/app/core.dart';

class UserRepo extends ActiveRepo<String, UserModel> {
  @override
  String get boxName => ModelTypeDefine.userBox;
}
