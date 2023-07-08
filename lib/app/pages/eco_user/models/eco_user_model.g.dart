// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eco_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EcoUserModel _$EcoUserModelFromJson(Map<String, dynamic> json) => EcoUserModel(
      userModel: json['userModel'] == null
          ? null
          : UserModel.fromJson(json['userModel'] as Map<String, dynamic>),
      totalRent: json['totalRent'] as int?,
      numFall: json['numFall'] as int?,
      backSide: json['backSide'] as String?,
      frontSide: json['frontSide'] as String?,
    );

Map<String, dynamic> _$EcoUserModelToJson(EcoUserModel instance) =>
    <String, dynamic>{
      'userModel': instance.userModel,
      'totalRent': instance.totalRent,
      'numFall': instance.numFall,
      'frontSide': instance.frontSide,
      'backSide': instance.backSide,
    };
