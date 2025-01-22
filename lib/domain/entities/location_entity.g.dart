// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationEntityAdapter extends TypeAdapter<LocationEntity> {
  @override
  final int typeId = 1;

  @override
  LocationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationEntity(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      placeName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocationEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.placeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
