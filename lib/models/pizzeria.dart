import 'package:hive/hive.dart';
import 'package:pizza/models/item.dart';

part 'pizzeria.g.dart';

@HiveType(typeId: 0)
class Pizzeria extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String pIva;

  @HiveField(3)
  String address;

  @HiveField(4)
  String phone;

  @HiveField(5)
  List<int> profilePicture;

  @HiveField(6)
  String email;

  @HiveField(7)
  List<Item> menu;

  Pizzeria({
    this.id,
    this.name,
    this.pIva,
    this.address,
    this.phone,
    this.profilePicture,
    this.menu,
  });

  Pizzeria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pIva = json['p_iva'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    profilePicture = json['image'] != null ? json['image']['data'] : null;
    if (json['menu'] != null)
      menu = json['menu'].map((item) => Item.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['p_iva'] = this.pIva;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.profilePicture;
    return data;
  }
}
