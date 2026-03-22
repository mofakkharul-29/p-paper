import 'package:flutter/material.dart';
import 'package:p_papper/core/constant/app_colors.dart';
import 'package:p_papper/core/utils/custom_text.dart';

class CustomAppBar {
  final String title;

  const CustomAppBar({this.title = ''});

  PreferredSizeWidget? _customAppBar(String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: AppBar(
        backgroundColor: AppColors.appBarBgColor,
        title: CustomText(
          text: title,
          color: Colors.black87,
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
