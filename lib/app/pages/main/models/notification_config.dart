import 'package:json_annotation/json_annotation.dart';
part 'notification_config.g.dart';

@JsonSerializable()
class NotificationConfig {
  String? message;
  int? hour;
  int? minutes;
  bool? isEnable;
  NotificationConfig({
    this.message,
    this.hour,
    this.minutes,
    this.isEnable,
  });
    factory NotificationConfig.fromJson(Map<String, dynamic> json) =>
      _$NotificationConfigFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationConfigToJson(this);
}
