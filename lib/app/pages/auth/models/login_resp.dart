import 'package:ecoveloapp/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_resp.g.dart';

@JsonSerializable()
@HiveType(typeId: ModelTypeDefine.login)
class LoginResp {
  LoginResp({
    this.token,
    this.refreshToken,
    this.expired,
    this.userResponse,
  });
  @HiveField(0)
  String? token;
  @HiveField(1)
  String? refreshToken;
  @HiveField(2)
  int? expired;
  @HiveField(3)
  UserModel? userResponse;
  factory LoginResp.fromJson(Map<String, dynamic> json) =>
      _$LoginRespFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRespToJson(this);
}