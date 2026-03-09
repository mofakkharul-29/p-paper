import 'package:flutter/material.dart';
import 'package:p_papper/core/utils/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: Alignment.topRight,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        overlayColor: Colors.transparent,
        iconAlignment: IconAlignment.start,
        side: BorderSide.none,
        elevation: 0.0,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: CustomText(
        text: text,
        color: Colors.black87,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
