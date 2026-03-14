import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/auth/data/login_form_notifier.dart';
import 'package:p_papper/features/auth/domain/repository/form_state.dart';

final loginFormNotifierProvider =
    NotifierProvider<LoginFormNotifier, LoginFormState>(
      LoginFormNotifier.new,
    );
