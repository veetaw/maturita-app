import 'package:hive/hive.dart';

part 'owner.g.dart';

@HiveType(typeId: 0)
class Owner extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String email;

  @HiveField(4)
  String token;

  @HiveField(5)
  List<int> profilePicture;

  Owner({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.token,
    this.profilePicture,
  });
}
