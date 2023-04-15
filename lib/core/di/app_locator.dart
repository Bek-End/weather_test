import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:it_fox_test/data/repositories/auth_repositories_impl.dart';
import 'package:it_fox_test/data/repositories/local_data_repository_impl.dart';
import 'package:it_fox_test/data/repositories/weather_repository_impl.dart';
import 'package:it_fox_test/data/services/weather_service.dart';
import 'package:it_fox_test/domain/entities/weather_entity.dart';
import 'package:it_fox_test/domain/repositories/auth_repository.dart';
import 'package:it_fox_test/domain/repositories/local_data_repository.dart';
import 'package:it_fox_test/domain/repositories/weather_repository.dart';
import 'package:it_fox_test/domain/usecases/auth.usecase.dart';
import 'package:it_fox_test/domain/usecases/weather.usecase.dart';
import 'package:it_fox_test/presentation/auth/bloc/auth_bloc.dart';
import 'package:it_fox_test/presentation/weather/bloc/weather_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AppLocator {
  static void getItInit() async {
    final getIt = GetIt.I;

    getIt.registerSingleton<LocalDataRepository>(LocalDataRepositoryImpl());

    getIt.registerSingleton<TokenRepository>(TokenRepositoryImpl());
    getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
    getIt.registerSingleton<AuthUsecase>(AuthUsecase());
    getIt.registerSingleton<AuthBloc>(AuthBloc());

    getIt.registerSingleton<WeatherService>(WeatherService(Dio()));
    getIt.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(getIt.get()));
    getIt.registerSingleton<WeatherUsecase>(WeatherUsecase());
    getIt.registerSingleton<WeatherBloc>(WeatherBloc());
  }

  static Future<void> hiveInit() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(WeatherEntityAdapter());
  }

  static Future<void> dispose() async {
    return GetIt.I.reset();
  }
}
