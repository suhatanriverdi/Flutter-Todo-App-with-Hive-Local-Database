import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final Function onSelectedColor;
  final List<Color> availableColors;
  final Color initialColor;
  final double height;
  final double width;

  const ColorPicker(
      {Key? key,
      required this.onSelectedColor,
      required this.availableColors,
      required this.initialColor,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _pickedColor;

  @override
  void initState() {
    _pickedColor = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 60,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: widget.availableColors.length,
          itemBuilder: (context, index) {
            final itemColor = widget.availableColors[index];
            return InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                widget.onSelectedColor(itemColor);
                setState(() {
                  _pickedColor = itemColor;
                });
              },
              child: Ink(
                child: itemColor == _pickedColor
                    ? const Center(
                        child: Icon(Icons.check, color: Colors.black54))
                    : null,
                decoration: BoxDecoration(
                    color: itemColor,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.grey)),
              ),
            );
          }),
    );
  }
}
