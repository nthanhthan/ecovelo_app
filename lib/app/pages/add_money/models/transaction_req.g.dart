// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionReq _$TransactionReqFromJson(Map<String, dynamic> json) =>
    TransactionReq(
      money: json['money'] as int?,
      titleTransaction: json['titleTransaction'] as String?,
      isMainPoint: json['isMainPoint'] as bool?,
      isStatus: json['isStatus'] as bool?,
    );

Map<String, dynamic> _$TransactionReqToJson(TransactionReq instance) =>
    <String, dynamic>{
      'money': instance.money,
      'titleTransaction': instance.titleTransaction,
      'isMainPoint': instance.isMainPoint,
      'isStatus': instance.isStatus,
    };
