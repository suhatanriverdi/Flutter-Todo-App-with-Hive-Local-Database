import 'package:hive/hive.dart';
import 'package:todo_list_hive/model/note.dart';

class Boxes {
  static Box<Note> getNotes() => Hive.box('notes');
}
