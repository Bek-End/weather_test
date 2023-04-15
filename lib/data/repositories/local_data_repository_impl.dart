import 'package:hive/hive.dart';
import 'package:it_fox_test/domain/entities/weather_entity.dart';
import 'package:it_fox_test/domain/repositories/local_data_repository.dart';

class LocalDataRepositoryImpl implements LocalDataRepository {
  @override
  Future<void> addWeatherRes(WeatherEntity weatherEntity) async {
    final box = await Hive.openBox<WeatherEntity>('WeatherEntity');
    return box.put('WeatherReq', weatherEntity);
  }

  @override
  Future<WeatherEntity?> getLastWeatherRes() async {
    final box = await Hive.openBox<WeatherEntity>('WeatherEntity');
    return box.get('WeatherReq');
  }
  
  @override
  Future<void> deleteWeatherRes() async {
    final box = await Hive.openBox<WeatherEntity>('WeatherEntity');
    await box.delete('WeatherReq');
  }
}
