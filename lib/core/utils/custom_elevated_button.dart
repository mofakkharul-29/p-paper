import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final Color? bgColor;
  final double? elevation;
  final Color? overlayColor;
  final Color? tintColor;
  final Size? fixedSize;
  final OutlinedBorder? shape;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.bgColor,
    this.elevation,
    this.overlayColor,
    this.tintColor,
    this.fixedSize,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: bgColor,
        overlayColor: overlayColor,
        surfaceTintColor: tintColor,
        fixedSize: fixedSize,
        shape: shape,
      ),
      child: child,
    );
  }
}
