// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pizzeria.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PizzeriaAdapter extends TypeAdapter<Pizzeria> {
  @override
  final typeId = 4;

  @override
  Pizzeria read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pizzeria(
      id: fields[0] as int,
      name: fields[1] as String,
      pIva: fields[2] as String,
      address: fields[3] as String,
      phone: fields[4] as String,
      profilePicture: (fields[5] as List)?.cast<int>(),
      menu: (fields[7] as List)?.cast<Item>(),
    )..email = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, Pizzeria obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.pIva)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.profilePicture)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.menu);
  }
}
