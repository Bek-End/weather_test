import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_queries_dto.g.dart';

@JsonSerializable()
class WeatherQueriesDto {
  WeatherQueriesDto({
    required this.lat,
    required this.lon,
    required this.apiKey,
  });

  final double lat;
  final double lon;
  @JsonKey(name: 'appid')
  final String apiKey;

  factory WeatherQueriesDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherQueriesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherQueriesDtoToJson(this);
}
