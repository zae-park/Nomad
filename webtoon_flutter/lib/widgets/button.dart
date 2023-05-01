import 'package:flutter/material.dart';

class Rounded extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;

  const Rounded(
      {super.key,
      required this.text,
      required this.textColor,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: bgColor,
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Text(
          text,
          style: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
