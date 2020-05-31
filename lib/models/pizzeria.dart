import 'package:hive/hive.dart';

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

  Pizzeria({
    this.id,
    this.name,
    this.pIva,
    this.address,
    this.phone,
    this.profilePicture,
  });
}
