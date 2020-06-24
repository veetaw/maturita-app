import 'package:hive/hive.dart';
import 'package:pizza/models/item.dart';
import 'package:pizza/models/pizzeria.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 6)
class CartItem extends HiveObject {
  @HiveField(0)
  Pizzeria pizzeria;

  @HiveField(1)
  List<Item> items;

  add(Item item) => items.add(item);
  remove(Item item) => items.remove(item);

  CartItem(this.pizzeria, this.items);
}
