// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      id: json['id'] as int?,
      titleTransaction: json['titleTransaction'] as String?,
      dateTimeTransaction: json['dateTimeTransaction'] as int?,
      point: (json['point'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleTransaction': instance.titleTransaction,
      'point': instance.point,
      'dateTimeTransaction': instance.dateTimeTransaction,
    };
