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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [
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
