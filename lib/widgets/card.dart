import 'package:flutter/material.dart';
import 'package:todo_list_hive/hive/boxes.dart';

import '../screens/add_update_note.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String description;
  final DateTime created;
  final Color color;
  final int noteKey;

  const CardWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.created,
      required this.color,
      required this.noteKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.105;
    double width = MediaQuery.of(context).size.width * 0.1;
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(20),
            color: color,
            child: ListTile(
              title: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                alignment: Alignment.topRight,
                icon: const Icon(
                  Icons.delete,
                ),
                onPressed: _onDelete,
              ),
              onTap: () {
                _toEditPage(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toEditPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddUpdateNote(
                noteKey: noteKey,
              )),
    );
  }

  void _onDelete() {
    final box = Boxes.getNotes();
    box.delete(noteKey);
  }
}
