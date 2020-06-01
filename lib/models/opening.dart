import 'package:hive/hive.dart';

part 'opening.g.dart';

@HiveType(typeId: 1)
class Opening extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String start;

  @HiveField(2)
  String end;

  Opening({
    this.id,
    this.start,
    this.end,
  });

  Opening.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
  }
}
