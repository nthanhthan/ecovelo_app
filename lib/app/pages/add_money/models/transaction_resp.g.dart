// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResp _$TransactionRespFromJson(Map<String, dynamic> json) =>
    TransactionResp(
      id: json['id'] as int?,
      point: (json['point'] as num?)?.toDouble(),
      dateTimeTransaction: json['dateTimeTransaction'] as int?,
    );

Map<String, dynamic> _$TransactionRespToJson(TransactionResp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'point': instance.point,
      'dateTimeTransaction': instance.dateTimeTransaction,
    };
