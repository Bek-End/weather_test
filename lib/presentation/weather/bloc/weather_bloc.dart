import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:it_fox_test/domain/entities/weather_entity.dart';
import 'package:it_fox_test/domain/usecases/weather.usecase.dart';
import 'package:location/location.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherLoading()) {
    final WeatherUsecase weatherUsecase = GetIt.I.get();
    LocationData? currentLocation;

    on<WeatherInitEvent>((event, emit) async {
      currentLocation = await _getLocation();

      if (currentLocation != null) {
        final weatherEntity = await weatherUsecase.getCurrentWeather(
          lat: currentLocation!.latitude!,
          lon: currentLocation!.longitude!,
        );

        if (weatherEntity != null) emit(WeatherCompleteState(weatherEntity));
      }
    });

    on<WeatherUpdateEvent>((event, emit) async {
      if (currentLocation != null) {
        final weatherEntity = await weatherUsecase.updateWeather(
          lat: currentLocation!.latitude!,
          lon: currentLocation!.longitude!,
        );

        if (weatherEntity != null) emit(WeatherCompleteState(weatherEntity));
      }
    });
  }

  Future<LocationData> _getLocation() async {
    return await Location().getLocation();
  }
}

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherInitEvent extends WeatherEvent {}

class WeatherUpdateEvent extends WeatherEvent {}

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {}

class WeatherCompleteState extends WeatherState {
  const WeatherCompleteState(this.weatherEntity);

  final WeatherEntity weatherEntity;

  @override
  List<Object> get props => [super.props, weatherEntity];
}
