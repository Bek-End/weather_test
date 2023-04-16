import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:it_fox_test/core/widgets/error_overlay.dart';
import 'package:it_fox_test/data/dto/weather_dto.dart';
import 'package:it_fox_test/data/dto/weather_queries_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_service.g.dart';

@RestApi(baseUrl: 'https://api.openweathermap.org')
abstract class WeatherService {
  factory WeatherService(Dio dio, {String? baseUrl}) {
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, _) {
        FirebaseCrashlytics.instance.recordError(e, e.stackTrace, fatal: true);
        showError(e.error.toString());
      },
    ));
    return _WeatherService(dio, baseUrl: baseUrl);
  }

  @GET('/data/2.5/weather')
  Future<WeatherDto> getCurrentWeather(@Queries() WeatherQueriesDto queries);
}
