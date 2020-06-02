import 'package:hive/hive.dart';

part 'item.g.dart';

enum ItemType { drink, pizza }

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  int id;

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

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.tryParse(json['price'].toString());
    type = fromString(json['type']);
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['type'] = type.asString;
    data['image'] = image;
    return data;
  }

  Map<String, dynamic> toJsonSimple() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

extension on ItemType {
  String get asString => this == ItemType.drink ? 'drink' : 'pizza';
}

ItemType fromString(String str) {
  if (str.toLowerCase() == 'drink') return ItemType.drink;
  if (str.toLowerCase() == 'pizza') return ItemType.pizza;
  throw Exception();
}
