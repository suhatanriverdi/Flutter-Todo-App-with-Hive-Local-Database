import 'package:flutter/material.dart';
import '../hive/boxes.dart';
import '../widgets/color_picker.dart';
import '../constants/colors.dart';
import '../model/note.dart';

class AddUpdateNote extends StatefulWidget {
  final int noteKey;

  const AddUpdateNote({Key? key, required this.noteKey}) : super(key: key);

  @override
  State<AddUpdateNote> createState() => _AddUpdateNoteState();
}

class _AddUpdateNoteState extends State<AddUpdateNote> {
  int _selectedColor = colorList.first.value;
  Color _iniatialColor = colorList.first;

  final GlobalKey<FormState> _formKey = GlobalKey();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // If we clicked on the card to edit existing card
    if (widget.noteKey != -1) {
      _fillFields();
    }

    double height = MediaQuery.of(context).size.height * 0.18;
    double width = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      backgroundColor: Color(_selectedColor),
      appBar: AppBar(
        title: const Text('Add | Update Note'),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ColorPicker(
              height: height,
              width: width,
              availableColors: colorList,
              initialColor: _iniatialColor,
              onSelectedColor: (value) {
                setState(() {
                  _selectedColor = value.value;
                });
              },
            ),
            // const SizedBox(height: 30.0),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value != null && value.trim().isEmpty) {
                    return "Title cannot be empty!";
                  }
                  return null;
                },
                controller: titleController,
                decoration: const InputDecoration(
                  filled: true,
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.red)),
                  border: UnderlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              controller: descriptionController,
              minLines: 4,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final bool? isValid = _formKey.currentState?.validate();
          if (isValid != null && isValid) {
            _saveNote(titleController.text, descriptionController.text,
                _selectedColor, DateTime.now());
          }
        },
        tooltip: 'Save Note',
        child: const Icon(Icons.save),
      ),
    );
  }

  Future _saveNote(
      String title, String description, int color, DateTime created) async {
    final note = Note()
      ..title = title
      ..description = description
      ..color = color
      ..created = created;

    final box = Boxes.getNotes();

    if (widget.noteKey == -1) {
      box.add(note);
    } else {
      // Updates existing note
      box.put(widget.noteKey, note);
    }

    Navigator.pop(context);
  }

  void _fillFields() {
    final box = Boxes.getNotes();
    final note = box.get(widget.noteKey);

    _iniatialColor = Color(note!.color);
    _selectedColor = note.color;
    titleController.text = note.title;
    descriptionController.text = note.description;
  }
}
