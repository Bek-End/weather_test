import 'package:it_fox_test/data/dto/weather_dto.dart';
import 'package:it_fox_test/data/dto/weather_queries_dto.dart';
import 'package:it_fox_test/data/services/weather_service.dart';
import 'package:it_fox_test/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl(this.service);

  final WeatherService service;

  @override
  Future<WeatherDto> getCurrentWeather(WeatherQueriesDto queries) async {
    try {
      return await service.getCurrentWeather(queries);
    } catch (e) {
      rethrow;
    }
  }
}
