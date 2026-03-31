import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        backgroundColor:
            Theme.of(
              context,
            ).bottomNavigationBarTheme.backgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: Theme.of(
          context,
        ).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(
          context,
        ).bottomNavigationBarTheme.unselectedItemColor,
        iconSize: 20,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
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
