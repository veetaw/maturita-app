import 'package:hive/hive.dart';
import 'package:pizza/models/item.dart';

part 'order.g.dart';

@HiveType(typeId: 2)
class Order extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime start;

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

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = DateTime.parse(json['start']);
    shipped = json['shipped'];
    delivered = json['delivered'];
    total = json['total'].toDouble();
    if (json['items'] != null) if (json['menu'] != null)
      items = json['menu'].map((item) => Item.fromJson(item)).toList();
  }
}
