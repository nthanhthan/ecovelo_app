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
    this.mainPoint,
    this.proPoint,
    this.verify,
    this.userId,
  });
  @HiveField(0)
  int? userId;
  @HiveField(1)
  String? phoneNumber;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? nameUser;
  @HiveField(4)
  bool? verify;
  @HiveField(5)
  double? mainPoint;
  @HiveField(6)
  double? proPoint;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
