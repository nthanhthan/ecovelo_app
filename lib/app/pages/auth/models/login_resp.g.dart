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
      accessToken: fields[0] as String,
      refreshToken: fields[1] as String,
      expired: fields[2] as int,
      userResponse: fields[3] as UserModel?,
      admin: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginResp obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.refreshToken)
      ..writeByte(2)
      ..write(obj.expired)
      ..writeByte(3)
      ..write(obj.userResponse)
      ..writeByte(4)
      ..write(obj.admin);
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
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expired: json['expired'] as int,
      userResponse: json['userResponse'] == null
          ? null
          : UserModel.fromJson(json['userResponse'] as Map<String, dynamic>),
      admin: json['admin'] as bool?,
    );

Map<String, dynamic> _$LoginRespToJson(LoginResp instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expired': instance.expired,
      'userResponse': instance.userResponse,
      'admin': instance.admin,
    };
