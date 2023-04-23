// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationModel _$StationModelFromJson(Map<String, dynamic> json) => StationModel(
      stationId: json['stationId'] as int?,
      address: json['address'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      numBicycle: json['numBicycle'] as int?,
    );

Map<String, dynamic> _$StationModelToJson(StationModel instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'numBicycle': instance.numBicycle,
    };
