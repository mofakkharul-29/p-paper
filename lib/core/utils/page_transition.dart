import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PageTransitionType {
  fade,
  slideFromRight,
  slideFromBottom,
  scale,
}

Page<T> buildCustomTransitionPage<T>({
  required LocalKey key,
  required Widget child,
  PageTransitionType transitionType =
      PageTransitionType.fade,
  Duration duration = const Duration(milliseconds: 300),
  Curve curve = Curves.easeInOut,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          switch (transitionType) {
            case PageTransitionType.fade:
              return FadeTransition(
                opacity: curvedAnimation,
                child: child,
              );

            case PageTransitionType.slideFromRight:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );

            case PageTransitionType.slideFromBottom:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );

            case PageTransitionType.scale:
              return ScaleTransition(
                scale: curvedAnimation,
                child: child,
              );
          }
        },
  );
}
