import 'package:hive/hive.dart';
import 'package:pizza/models/item.dart';

part 'order.g.dart';

@HiveType(typeId: 0)
class Order extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String start;

  @HiveField(2)
  bool shipped;

  @HiveField(3)
  bool delivered;

  @HiveField(4)
  double total;

  @HiveField(5)
  List<Item> items;

  @HiveField(6)
  int pizzeriaId;

  Order({
    this.id,
    this.start,
    this.shipped,
    this.delivered,
    this.total,
    this.items,
    this.pizzeriaId,
  });
}
