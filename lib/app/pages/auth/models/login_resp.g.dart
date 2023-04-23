// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_resp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginRespAdapter extends TypeAdapter<LoginResp> {
  @override
  final int typeId = 2;

  @override
  LoginResp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginResp(
      token: fields[0] as String?,
      refreshToken: fields[1] as String?,
      expired: fields[2] as int?,
      userResponse: fields[3] as UserModel?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginResp obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.refreshToken)
      ..writeByte(2)
      ..write(obj.expired)
      ..writeByte(3)
      ..write(obj.userResponse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginRespAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResp _$LoginRespFromJson(Map<String, dynamic> json) => LoginResp(
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      expired: json['expired'] as int?,
      userResponse: json['userResponse'] == null
          ? null
          : UserModel.fromJson(json['userResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginRespToJson(LoginResp instance) => <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'expired': instance.expired,
      'userResponse': instance.userResponse,
    };
