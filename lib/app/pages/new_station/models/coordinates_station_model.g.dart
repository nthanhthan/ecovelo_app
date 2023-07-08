// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates_station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinateStationModel _$CoordinateStationModelFromJson(
        Map<String, dynamic> json) =>
    CoordinateStationModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordinateStationModelToJson(
        CoordinateStationModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
