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
      phoneNumber: fields[1] as String?,
      email: fields[2] as String?,
      nameUser: fields[3] as String?,
      money: fields[5] as double?,
      verify: fields[4] as bool?,
    )
      ..userId = fields[0] as int?
      ..proPoint = fields[6] as double?;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.nameUser)
      ..writeByte(4)
      ..write(obj.verify)
      ..writeByte(5)
      ..write(obj.money)
      ..writeByte(6)
      ..write(obj.proPoint);
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
    )
      ..userId = json['userId'] as int?
      ..proPoint = (json['proPoint'] as num?)?.toDouble();

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'nameUser': instance.nameUser,
      'verify': instance.verify,
      'money': instance.money,
      'proPoint': instance.proPoint,
    };
