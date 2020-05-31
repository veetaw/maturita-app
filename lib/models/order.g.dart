// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final typeId = 0;

  @override
  Order read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      id: fields[0] as int,
      start: fields[1] as String,
      shipped: fields[2] as bool,
      delivered: fields[3] as bool,
      total: fields[4] as double,
      items: (fields[5] as List)?.cast<Item>(),
      pizzeriaId: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.shipped)
      ..writeByte(3)
      ..write(obj.delivered)
      ..writeByte(4)
      ..write(obj.total)
      ..writeByte(5)
      ..write(obj.items)
      ..writeByte(6)
      ..write(obj.pizzeriaId);
  }
}
