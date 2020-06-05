import 'package:hive/hive.dart';

part 'owner.g.dart';

@HiveType(typeId: 3)
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
  List<int> profilePicture;

  Owner({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePicture,
  });

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    profilePicture = json['profile_picture'] != null
        ? List<int>.from(json['profile_picture']['data'])
        : null;
  }
}
