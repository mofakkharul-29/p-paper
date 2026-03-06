import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  const CustomText({
    super.key,
    required this.text,
    this.fontWeight,
    this.color,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
