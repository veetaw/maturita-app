import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String email;

  @HiveField(4)
  String address;

  @HiveField(5)
  String phone;

  @HiveField(6)
  List<int> profilePicture;

  @HiveField(7)
  String token;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
    this.phone,
    this.profilePicture,
    this.token,
  });
}
