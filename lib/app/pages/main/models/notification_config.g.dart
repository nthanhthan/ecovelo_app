// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationConfig _$NotificationConfigFromJson(Map<String, dynamic> json) =>
    NotificationConfig(
      message: json['message'] as String?,
      hour: json['hour'] as int?,
      minutes: json['minutes'] as int?,
      isEnable: json['isEnable'] as bool?,
    );

Map<String, dynamic> _$NotificationConfigToJson(NotificationConfig instance) =>
    <String, dynamic>{
      'message': instance.message,
      'hour': instance.hour,
      'minutes': instance.minutes,
      'isEnable': instance.isEnable,
    };
