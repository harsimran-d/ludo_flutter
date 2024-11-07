import 'package:flutter/material.dart';

class BaseGrid extends StatelessWidget {
  const BaseGrid({
    super.key,
    required this.boxWidth,
  });

  final double boxWidth;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: boxWidth,
      ),
      itemBuilder: (context, index) {
        return Container(
          width: boxWidth,
          height: boxWidth,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0x66000000)),
              color: _getColor(index)),
          child: Center(child: _getChild(index, boxWidth)),
        );
      },
      itemCount: 15 * 15,
    );
  }
}

Widget? _getChild(int index, double boxWidth) {
  const starPlaces = [36, 102, 188, 122];
  if (starPlaces.contains(index)) {
    return Icon(
      Icons.star_outline_rounded,
      size: boxWidth,
      color: Colors.black45,
    );
  } else if (index == 7) {
    return Icon(
      Icons.arrow_downward,
      size: boxWidth * 0.75,
      color: const Color(0xFF479D52),
    );
  } else if (index == 119) {
    return Icon(
      Icons.arrow_back,
      size: boxWidth * 0.75,
      color: const Color.fromARGB(255, 255, 216, 21),
    );
  } else if (index == 217) {
    return Icon(
      Icons.arrow_upward,
      size: boxWidth * 0.75,
      color: Colors.blue,
    );
  } else if (index == 105) {
    return Icon(
      Icons.arrow_forward,
      size: boxWidth * 0.75,
      color: const Color(0xFFD93830),
    );
  } else {
    return null;
  }
}

Color _getColor(int index) {
  // later pick colors from the theme
  const red = Colors.red;
  const green = Color(0xFF479D52);
  const yellow = Color.fromARGB(255, 255, 216, 21);
  const blue = Colors.blue;

  final redBoxes = [91, 106, 107, 108, 109, 110];
  final greenBoxes = [22, 23, 37, 52, 67, 82];
  final yellowBoxes = [114, 115, 116, 117, 118, 133];
  final blueBoxes = [201, 202, 187, 172, 157, 142];

  if (redBoxes.contains(index)) {
    return red;
  } else if (greenBoxes.contains(index)) {
    return green;
  } else if (yellowBoxes.contains(index)) {
    return yellow;
  } else if (blueBoxes.contains(index)) {
    return blue;
  } else {
    return Colors.transparent;
  }
}
