import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:p_papper/core/routing/route_name.dart';
import 'package:p_papper/core/routing/routing_refresh_listenable.dart';
import 'package:p_papper/features/auth/presentation/login_page.dart';
import 'package:p_papper/features/auth/presentation/registration_page.dart';
import 'package:p_papper/features/news/news_screen.dart';
import 'package:p_papper/features/onboarding/presentation/onboarding_screen.dart';
import 'package:p_papper/features/splash/presentation/splash_screen.dart';

class RouterConfiguration {
  static final _rootNavigationKey =
      GlobalKey<NavigatorState>();
  static final routerProvider = Provider<GoRouter>((ref) {
    final routerNotifier = ref.watch(
      routerListenableProvider,
    );

    return GoRouter(
      initialLocation: '/splash',
      navigatorKey: _rootNavigationKey,
      debugLogDiagnostics: true,
      refreshListenable: routerNotifier,
      redirect: (context, state) {
        final String path = state.uri.path;

        final bool isSplashDone =
            routerNotifier.isSplashDont;
        final bool isFirstLaunch =
            routerNotifier.isFirstLaunch;
        final bool isAppLoading =
            routerNotifier.isAppLoading;
        final user = routerNotifier.currentUser;

        if (isAppLoading) {
          if (path != '/splash') return '/splash';
          return null;
        }

        if (!isSplashDone) {
          if (path != '/splash') return '/splash';
          return null;
        }

        if (isFirstLaunch) {
          if (path != '/onboarding') return '/onboarding';
          return null;
        }

        final authPath = ['/login', '/register'];
        if (user == null) {
          if (!authPath.contains(path)) return '/login';
          return null;
        }
        if (authPath.contains(path) ||
            path == '/onboarding' ||
            path == '/splash') {
          return '/news';
        }
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          name: splashRoute,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          name: onboardingRoute,
          builder: (context, state) =>
              const OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          name: loginRoute,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          name: registerRoute,
          builder: (context, state) =>
              const RegistrationPage(),
        ),
        GoRoute(
          path: '/news',
          name: newsRoute,
          builder: (context, state) => const NewsScreen(),
        ),
      ],
    );
  });
}
