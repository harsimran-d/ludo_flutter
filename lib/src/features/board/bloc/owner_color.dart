import 'package:flutter/material.dart';

enum OwnerColor {
  green(myColor: Colors.green, title: 'Green'),
  blue(myColor: Colors.blue, title: 'Blue'),
  red(myColor: Colors.red, title: 'Red'),
  yellow(myColor: Colors.yellow, title: 'Yellow');

  const OwnerColor({
    required this.myColor,
    required this.title,
  });

  final Color myColor;
  final String title;
}
