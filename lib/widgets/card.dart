import 'dart:ui';

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
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: height * 0.01),
        height: height * 0.08,
        child: MaterialButton(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height * 0.025),
          ),
          color: color,
          onPressed: () {
            _toEditPage(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: height * 0.02, fontWeight: FontWeight.w300),
                    ),
                    Text(description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: height * 0.016,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
              ),
            ],
          ),
        ));
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
}
