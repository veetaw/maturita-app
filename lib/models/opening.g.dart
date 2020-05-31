// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OpeningAdapter extends TypeAdapter<Opening> {
  @override
  final typeId = 0;

  @override
  Opening read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Opening(
      id: fields[0] as int,
      start: fields[1] as String,
      end: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Opening obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.end);
  }
}
