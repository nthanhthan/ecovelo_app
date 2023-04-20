import 'package:json_annotation/json_annotation.dart';
part 'station_model.g.dart';

@JsonSerializable()
class StationModel {
  int? stationId;
  String? address;
  double? lat;
  double? lng;
  int? numBicycle;
  StationModel({
    this.stationId,
    this.address,
    this.lat,
    this.lng,
    this.numBicycle,
  });
    factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);

  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}
