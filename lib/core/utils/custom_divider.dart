import 'package:flutter/material.dart';
import 'package:p_papper/core/utils/custom_text.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: getDivider(height: 2.0)),
        const CustomText(
          text: 'OR',
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
        Expanded(child: getDivider(height: 2.0)),
      ],
    );
  }

  Widget getDivider({
    double height = 1.2,
    Color color = Colors.black87,
    double indent = 5.0,
    double radius = 5.0,
    endIndent = 5.0,
    double thickness = 15.0,
  }) {
    return Divider(
      height: height,
      color: color,
      indent: indent,
      endIndent: endIndent,
      radius: BorderRadius.circular(radius),
      thickness: thickness,
    );
  }
}
