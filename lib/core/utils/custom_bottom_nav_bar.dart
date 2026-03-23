import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_papper/core/constant/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CustomBottomNavBar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.08,
      child: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (value) {
          navigationShell.goBranch(
            value,
            initialLocation:
                value == navigationShell.currentIndex,
          );
        },
        backgroundColor: AppColors.appBarBgColor,
        selectedItemColor: const Color.fromRGBO(
          0,
          0,
          0,
          0.867,
        ),
        unselectedItemColor: const Color.fromRGBO(
          0,
          0,
          0,
          0.867,
        ),
        iconSize: 20,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          _bottomNavigationBarItem(
            label: 'News',
            icon: Icons.article_outlined,
            activeIcon: Icons.article,
          ),
          _bottomNavigationBarItem(
            label: 'Bookmarks',
            icon: Icons.bookmark_outline,
            activeIcon: Icons.bookmark,
          ),
          _bottomNavigationBarItem(
            label: 'Profile',
            icon: Icons.person_outline,
            activeIcon: Icons.person,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    String? label,
    required IconData icon,
    required IconData activeIcon,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
    );
  }
}
