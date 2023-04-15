import 'package:hive/hive.dart';

part 'weather_entity.g.dart';

@HiveType(typeId: 0, adapterName: 'WeatherEntityAdapter')
class WeatherEntity extends HiveObject {
  WeatherEntity({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.desc,
    required this.cityName,
    required this.dateTime,
  });

  @HiveField(0)
  final int temp;
  @HiveField(1)
  final int feelsLike;
  @HiveField(2)
  final int humidity;
  @HiveField(3)
  final String desc;
  @HiveField(4)
  final String cityName;
  @HiveField(5)
  final DateTime dateTime;
}
