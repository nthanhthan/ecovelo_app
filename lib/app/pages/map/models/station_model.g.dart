// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationModel _$StationModelFromJson(Map<String, dynamic> json) => StationModel(
      id: json['id'] as int?,
      address: json['address'] as String?,
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      numBicycle: json['numBicycle'] as int?,
    );

Map<String, dynamic> _$StationModelToJson(StationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'numBicycle': instance.numBicycle,
    };
