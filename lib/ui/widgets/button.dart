import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  MyButton({required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
