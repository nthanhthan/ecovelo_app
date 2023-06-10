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
      mainPoint: fields[5] as double?,
      proPoint: fields[6] as double?,
      verify: fields[4] as bool?,
      userId: fields[0] as int?,
      proccessing: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.mainPoint)
      ..writeByte(6)
      ..write(obj.proPoint)
      ..writeByte(7)
      ..write(obj.proccessing);
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
      mainPoint: (json['mainPoint'] as num?)?.toDouble(),
      proPoint: (json['proPoint'] as num?)?.toDouble(),
      verify: json['verify'] as bool?,
      userId: json['userId'] as int?,
      proccessing: json['proccessing'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'nameUser': instance.nameUser,
      'verify': instance.verify,
      'mainPoint': instance.mainPoint,
      'proPoint': instance.proPoint,
      'proccessing': instance.proccessing,
    };
