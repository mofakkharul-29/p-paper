import 'package:flutter/material.dart';
import 'package:p_papper/core/constant/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.appBarBgColor,
      
      items: [
        _bottomNavigationBarItem(
          label: 'News Feeds',
          icon: Icons.newspaper_outlined,
        ),
        _bottomNavigationBarItem(
          label: 'Bookmarks',
          icon: Icons.bookmark_outline,
        ),
        _bottomNavigationBarItem(
          label: 'Profile',
          icon: Icons.person_outline
          ),
      ],
    );
  }

  dynamic _bottomNavigationBarItem({
    String? label,
    required IconData icon,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );
  }
}
