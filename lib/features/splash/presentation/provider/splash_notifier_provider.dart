import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/splash/data/splash_notifier.dart';

final splashNotifierProvider =
    NotifierProvider<SplashNotifier, bool>(
      SplashNotifier.new,
    );
