import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_papper/core/utils/body_container.dart';
import 'package:p_papper/core/utils/custom_app_bar.dart';
import 'package:p_papper/core/utils/custom_bottom_nav_bar.dart';

class Home extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final String path;
  const Home({
    super.key,
    required this.navigationShell,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    final appBar = CustomAppBar(title: setTitle(path));

    return Scaffold(
      appBar: appBar.customAppbar,
      body: BodyContainer(child: navigationShell),
      bottomNavigationBar: CustomBottomNavBar(
        navigationShell: navigationShell,
      ),
    );
  }

  String setTitle(String path) {
    switch (path) {
      case '/news':
        return 'News Feeds';

      case '/bookmarks':
        return 'Your News';

      case '/profile':
        return 'Profile';

      default:
        return '';
    }
  }
}
