import 'package:json_annotation/json_annotation.dart';
import 'package:ecoveloapp/app/core.dart';
part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.user)
class UserModel {
  UserModel({
    this.phoneNumber,
    this.email,
    this.nameUser,
    this.money,
    this.verify,
  });
  @HiveField(0)
  String? phoneNumber;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? nameUser;
  @HiveField(3)
  bool? verify;
  @HiveField(4)
  double? money;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
