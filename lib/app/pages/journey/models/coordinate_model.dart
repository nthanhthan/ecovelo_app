import 'package:json_annotation/json_annotation.dart';
part 'coordinate_model.g.dart';

@JsonSerializable()
class CoordinateModel {
  String? lat;
  String? lng;
  CoordinateModel({this.lat, this.lng});
    factory CoordinateModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateModelToJson(this);
}
