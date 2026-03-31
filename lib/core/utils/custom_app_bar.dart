import 'package:flutter/material.dart';
import 'package:p_papper/core/utils/custom_text.dart';

class CustomAppBar {
  final String title;
  final BuildContext context;

  const CustomAppBar({
    this.title = '',
    required this.context,
  });

  PreferredSizeWidget? _customAppBar(String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: CustomText(
          text: title,
          color: Theme.of(
            context,
          ).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        centerTitle: true,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            color: Colors.black12,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget? get customAppbar =>
      _customAppBar(title);
}
