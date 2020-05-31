import 'package:hive/hive.dart';

part 'opening.g.dart';

@HiveType(typeId: 0)
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
}