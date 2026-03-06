import 'package:flutter/material.dart';

class CustomAnimatedContainer extends StatelessWidget {
  final bool isActive;
  const CustomAnimatedContainer({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: isActive ? 18 : 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.black87 : Colors.white70,
        borderRadius: BorderRadiusGeometry.circular(5),
      ),
    );
  }
}
