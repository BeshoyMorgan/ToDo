import 'package:flutter/material.dart';

class TextUtil extends StatelessWidget {
  String title;
  Color color;
  double fontSize;
  FontWeight fontWeight;

  TextUtil({required this.title, required this.color, required this.fontSize, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
