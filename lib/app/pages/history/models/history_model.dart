import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel {
  int? id;
  String? titleTransaction;
  double? point;
  int? dateTimeTransaction;
  HistoryModel({
    this.id,
    this.titleTransaction,
    this.dateTimeTransaction,
    this.point,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
