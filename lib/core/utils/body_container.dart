import 'package:flutter/material.dart';
import 'package:p_papper/core/utils/scaffold_body_container_color.dart';

class BodyContainer extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  const BodyContainer({
    super.key,
    required this.child,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: isDark
              ? [
                  const Color(0xFF1E1E1E),
                  const Color(0xFF121212),
                ]
              : [
                  gradientStart,
                  gradientMiddle,
                  gradientEnd,
                ],
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
