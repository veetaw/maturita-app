import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 5)
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

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
    this.phone,
    this.profilePicture,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    profilePicture = json['profile_picture'] != null
        ? json['profile_picture']['data']
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}
