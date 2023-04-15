// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherEntityAdapter extends TypeAdapter<WeatherEntity> {
  @override
  final int typeId = 0;

  @override
  WeatherEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherEntity(
      temp: fields[0] as int,
      feelsLike: fields[1] as int,
      humidity: fields[2] as int,
      desc: fields[3] as String,
      cityName: fields[4] as String,
      dateTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.temp)
      ..writeByte(1)
      ..write(obj.feelsLike)
      ..writeByte(2)
      ..write(obj.humidity)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.cityName)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
