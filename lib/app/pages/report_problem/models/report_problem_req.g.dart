// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_problem_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportProblemReq _$ReportProblemReqFromJson(Map<String, dynamic> json) =>
    ReportProblemReq(
      description: json['description'] as String?,
      idBicycle: json['idBicycle'] as String?,
      idProblem: json['idProblem'] as int?,
      token: json['token'] as String?,
      urlImage: json['urlImage'] as String?,
    );

Map<String, dynamic> _$ReportProblemReqToJson(ReportProblemReq instance) =>
    <String, dynamic>{
      'description': instance.description,
      'idBicycle': instance.idBicycle,
      'urlImage': instance.urlImage,
      'idProblem': instance.idProblem,
      'token': instance.token,
    };
