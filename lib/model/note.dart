import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late final String title;

  @HiveField(1)
  late final String description;

  @HiveField(2)
  late final DateTime created;

  @HiveField(3)
  late final int color;
}
