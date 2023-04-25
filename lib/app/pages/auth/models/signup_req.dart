import 'package:json_annotation/json_annotation.dart';
part 'signup_req.g.dart';

@JsonSerializable()
class SignUpReq {
  String phoneNumber;
  String nameUser;
  String email;
  String password;
  SignUpReq({
    required this.phoneNumber,
    required this.email,
    required this.nameUser,
    required this.password,
  });
  factory SignUpReq.fromJson(Map<String, dynamic> json) =>
      _$SignUpReqFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpReqToJson(this);
}
