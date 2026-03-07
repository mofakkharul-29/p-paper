import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingNotifier extends AsyncNotifier<bool> {
  late final SharedPreferences _preferences;

  @override
  Future<bool> build() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getBool('isFirstLaunch') ?? true;
  }

  Future<void> setIsFirstLaunch() async {
    state = const AsyncLoading();
    await _preferences.setBool('isFirstLaunch', false);
    state = const AsyncValue.data(false);
  }
}
