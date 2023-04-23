// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      phoneNumber: fields[0] as String?,
      email: fields[1] as String?,
      nameUser: fields[2] as String?,
      money: fields[4] as double?,
      verify: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.phoneNumber)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.nameUser)
      ..writeByte(3)
      ..write(obj.verify)
      ..writeByte(4)
      ..write(obj.money);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      nameUser: json['nameUser'] as String?,
      money: (json['money'] as num?)?.toDouble(),
      verify: json['verify'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'nameUser': instance.nameUser,
      'verify': instance.verify,
      'money': instance.money,
    };