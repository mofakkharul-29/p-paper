import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void splashCompleted() {
    state = true;
  }

  void changeSplash(bool value) {
    state = value;
  }

  void resetSplash() {
    state = false;
  }

  bool get splashStatus => state;
}
