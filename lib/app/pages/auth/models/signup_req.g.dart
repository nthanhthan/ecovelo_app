// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpReq _$SignUpReqFromJson(Map<String, dynamic> json) => SignUpReq(
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      nameUser: json['nameUser'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpReqToJson(SignUpReq instance) => <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'nameUser': instance.nameUser,
      'email': instance.email,
      'password': instance.password,
    };
