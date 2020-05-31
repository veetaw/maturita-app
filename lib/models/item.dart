import 'package:hive/hive.dart';

part 'item.g.dart';

enum ItemType { drink, pizza }

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  ItemType type;

  @HiveField(4)
  List<int> image;

  Item({
    this.id,
    this.name,
    this.price,
    this.type,
    this.image,
  });
}
