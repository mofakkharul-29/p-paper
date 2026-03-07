import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/auth/data/auth_state_change_provider.dart';
import 'package:p_papper/features/auth/domain/app_user.dart';
import 'package:p_papper/features/onboarding/presentation/provider/onboarding_notifier_provider.dart';
import 'package:p_papper/features/splash/presentation/provider/splash_notifier_provider.dart';

class RoutingRefreshListenable extends ChangeNotifier {
  final Ref ref;

  bool _isSplashDone = false;
  bool _isFirstLaunch = true;
  AppUser? _currentUser;
  bool _isOnboardingLoading = true;
  bool _isAuthLoading = true;

  RoutingRefreshListenable(this.ref) {
    _isSplashDone = ref.read(splashNotifierProvider);

    final onboardingState = ref.read(
      onboardingStatusProvider,
    );
    _isOnboardingLoading = onboardingState.isLoading;
    _isFirstLaunch = onboardingState.value ?? true;

    final authState = ref.read(appUserProvider);
    _isAuthLoading = authState.isLoading;
    _currentUser = authState.value;

    ref.listen(onboardingStatusProvider, (previous, next) {
      final newOnboardingLoading = next.isLoading;
      final isNewFirstLaunch = next.value ?? true;

      if (_isOnboardingLoading != newOnboardingLoading ||
          _isFirstLaunch != isNewFirstLaunch) {
        _isOnboardingLoading = newOnboardingLoading;
        _isFirstLaunch = isNewFirstLaunch;
        notifyListeners();
      }
    });

    ref.listen(appUserProvider, (previous, next) {
      final newAuthLoading = next.isLoading;
      final newUser = next.value;

      if (_isAuthLoading != newAuthLoading ||
          _currentUser != newUser) {
        _isAuthLoading = newAuthLoading;
        _currentUser = newUser;
        notifyListeners();
      }
    });

    ref.listen(splashNotifierProvider, (previous, next) {
      if (_isSplashDone != next) {
        _isSplashDone = next;
        notifyListeners();
      }
    });
  }

  bool get isSplashDont => _isSplashDone;
  bool get isFirstLaunch => _isFirstLaunch;
  AppUser? get currentUser => _currentUser;
  bool get isAppLoading =>
      _isOnboardingLoading || _isAuthLoading;
}

final routerListenableProvider =
    Provider<RoutingRefreshListenable>(
      (ref) => RoutingRefreshListenable(ref),
    );
