import 'package:json_annotation/json_annotation.dart';
part 'coordinates_station_model.g.dart';

@JsonSerializable()
class CoordinateStationModel {
  double? lat;
  double? lng;
  CoordinateStationModel({this.lat, this.lng});
  factory CoordinateStationModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinateStationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateStationModelToJson(this);
}
