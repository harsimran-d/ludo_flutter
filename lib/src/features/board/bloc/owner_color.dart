import 'package:flutter/material.dart';

enum OwnerColor {
  green(myColor: Colors.green),
  blue(myColor: Colors.blue),
  red(myColor: Colors.red),
  yellow(myColor: Colors.yellow);

  const OwnerColor({required this.myColor});

  final Color myColor;
}
