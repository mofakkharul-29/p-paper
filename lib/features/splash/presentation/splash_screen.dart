import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/core/utils/scaffold_body_container_color.dart';
import 'package:p_papper/features/splash/presentation/provider/splash_notifier_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _scaleAnimation = Tween<double>(begin: 0.1, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutBack,
          ),
        );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ref
            .read(splashNotifierProvider.notifier)
            .splashCompleted();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              gradientStart,
              gradientMiddle,
              gradientEnd,
            ],
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: const Icon(
              Icons.rocket_launch_outlined,
              size: 125,
              color: Colors.black87,
              shadows: [
                Shadow(
                  color: Colors.black87,
                  blurRadius: 15.5,
                  offset: Offset(6.6, 5.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
