import 'package:get_it/get_it.dart';
import 'package:it_fox_test/core/widgets/error_overlay.dart';
import 'package:it_fox_test/data/dto/weather_queries_dto.dart';
import 'package:it_fox_test/domain/entities/weather_entity.dart';
import 'package:it_fox_test/domain/repositories/auth_repository.dart';
import 'package:it_fox_test/domain/repositories/local_data_repository.dart';
import 'package:it_fox_test/domain/repositories/weather_repository.dart';

class WeatherUsecase {
  final WeatherRepository _weatherRepository = GetIt.I.get();
  final TokenRepository _tokenRepository = GetIt.I.get();
  final LocalDataRepository _localDataRepository = GetIt.I.get();

  Future<WeatherEntity?> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final lastWeatherRes = await _getLastWeatherRes();
      if (lastWeatherRes != null) return lastWeatherRes;
      return await updateWeather(lat: lat, lon: lon);
    } catch (e) {
      showError(e.toString());
    }
    return null;
  }

  Future<WeatherEntity?> updateWeather({
    required double lat,
    required double lon,
  }) async {
    final apiKey = await _tokenRepository.readToken();

    final dto = await _weatherRepository.getCurrentWeather(
      WeatherQueriesDto(
        lat: lat,
        lon: lon,
        apiKey: apiKey ?? '',
      ),
    );

    final mainData = dto.main;
    final weatherEntity = WeatherEntity(
      temp: (mainData.temp - 273).toInt(),
      feelsLike: (mainData.feelsLike - 273).toInt(),
      humidity: mainData.humidity,
      desc: dto.weather.first.description,
      cityName: dto.name,
      dateTime: DateTime.now(),
    );

    await _localDataRepository.addWeatherRes(weatherEntity);
    return weatherEntity;
  }

  Future<WeatherEntity?> _getLastWeatherRes() async {
    final updateTime = DateTime.now().add(const Duration(hours: -1));
    final weatherFromLocalData = await _localDataRepository.getLastWeatherRes();
    final mustUpdateCash = weatherFromLocalData?.dateTime.isBefore(updateTime) ?? true;
    return mustUpdateCash ? null : weatherFromLocalData;
  }
}
