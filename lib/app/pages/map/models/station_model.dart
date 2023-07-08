import 'package:json_annotation/json_annotation.dart';
part 'station_model.g.dart';

@JsonSerializable()
class StationModel {
  int? id;
  String? address;
  double? lat;
  double? lng;
  int? numBicycle;
  String? distance;
  bool? isNewStation;
  StationModel({
    this.id,
    this.address,
    this.lat,
    this.lng,
    this.numBicycle,
    this.distance,
    this.isNewStation,
  });
  factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);

  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}
