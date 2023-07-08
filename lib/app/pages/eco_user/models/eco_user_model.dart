import 'package:ecoveloapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'eco_user_model.g.dart';

@JsonSerializable()
class EcoUserModel {
  UserModel? userModel;
  int? totalRent;
  int? numFall;
  String? frontSide;
  String? backSide;
  EcoUserModel({
    this.userModel,
    this.totalRent,
    this.numFall,
    this.backSide,
    this.frontSide,
  });
  factory EcoUserModel.fromJson(Map<String, dynamic> json) =>
      _$EcoUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$EcoUserModelToJson(this);
  String getTypeAuthencation() {
    if (userModel?.verify == true) {
      return TypeAuthencation.authencated;
    } else if (userModel?.verify == false && userModel?.proccessing == true) {
      return TypeAuthencation.processing;
    } else {
      return TypeAuthencation.unAuthencated;
    }
  }
}

abstract class TypeAuthencation {
  static String authencated = S.of(Get.context!).authencated;
  static String unAuthencated = S.of(Get.context!).unAuthencated;
  static String processing = S.of(Get.context!).processAuthen;
}
