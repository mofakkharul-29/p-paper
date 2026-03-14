import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/auth/data/auth_notifier.dart';
import 'package:p_papper/features/auth/domain/app_user.dart';

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AppUser?>(
      AuthNotifier.new,
    );
