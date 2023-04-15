import 'package:it_fox_test/data/dto/weather_dto.dart';
import 'package:it_fox_test/data/dto/weather_queries_dto.dart';

abstract class WeatherRepository {
  Future<WeatherDto> getCurrentWeather(WeatherQueriesDto queries);
}
