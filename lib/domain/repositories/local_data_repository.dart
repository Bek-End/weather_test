import 'package:it_fox_test/domain/entities/weather_entity.dart';

abstract class LocalDataRepository {
  Future<void> addWeatherRes(WeatherEntity weatherEntity);
  Future<WeatherEntity?> getLastWeatherRes();
  Future<void> deleteWeatherRes();
}
