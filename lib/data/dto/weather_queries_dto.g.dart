// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_queries_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherQueriesDto _$WeatherQueriesDtoFromJson(Map<String, dynamic> json) =>
    WeatherQueriesDto(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      apiKey: json['appid'] as String,
    );

Map<String, dynamic> _$WeatherQueriesDtoToJson(WeatherQueriesDto instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'appid': instance.apiKey,
    };
