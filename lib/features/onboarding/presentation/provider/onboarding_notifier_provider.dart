import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/onboarding/data/onboarding_notifier.dart';

final onboardingStatusProvider =
    AsyncNotifierProvider<OnboardingNotifier, bool>(
      OnboardingNotifier.new,
    );
