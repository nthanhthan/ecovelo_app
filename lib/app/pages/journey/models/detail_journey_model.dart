import 'package:ecoveloapp/app/core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DetailJouneyModel {
  int? id;
  int? beginTimeRent;
  int? endTimeRent;
  CoordinateModel? coordinateBeginStaion;
  CoordinateModel? coordinateEndStaion;
  double? money;
  List<CoordinateModel>? detailTrip;
  double? totalTime;
  double? distance;
  double? carbonReduced;
  double? energy;
  DetailJouneyModel({
    this.id,
    this.beginTimeRent,
    this.endTimeRent,
    this.coordinateBeginStaion,
    this.coordinateEndStaion,
    this.detailTrip,
    this.money,
    this.totalTime,
    this.distance,
    this.carbonReduced,
    this.energy,
  });
  factory DetailJouneyModel.fromJson(Map<String, dynamic> json) {
    int? beginTime = json['beginTimeRent'] as int?;
    int? endTimeRent = json['endTimeRent'] as int?;
    double totalTime = (endTimeRent! - beginTime!) / 1000;
    CoordinateModel? beginStation = json['coordinateBeginStaion'] == null
        ? null
        : CoordinateModel.fromJson(
            json['coordinateBeginStaion'] as Map<String, dynamic>);
    CoordinateModel? endStation = json['coordinateEndStaion'] == null
        ? null
        : CoordinateModel.fromJson(
            json['coordinateEndStaion'] as Map<String, dynamic>);
    double distance = Geolocator.distanceBetween(
        double.parse(beginStation?.lat ?? "0"),
        double.parse(beginStation?.lng ?? "0"),
        double.parse(endStation?.lat ?? "0"),
        double.parse(endStation?.lng ?? "0"));
    double energy = (7 * 60 * totalTime/60) / 60;
    return DetailJouneyModel(
      id: json['id'] as int?,
      beginTimeRent: beginTime,
      endTimeRent: endTimeRent,
      coordinateBeginStaion: beginStation,
      coordinateEndStaion: endStation,
      detailTrip: (json['detailTrip'] as List<dynamic>?)
          ?.map((e) => CoordinateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      money: (json['money'] as num?)?.toDouble(),
      totalTime: totalTime,
      distance: distance,
      energy: energy,
    );
  }
}
