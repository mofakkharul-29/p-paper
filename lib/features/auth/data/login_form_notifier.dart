import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/auth/domain/repository/form_state.dart';

class LoginFormNotifier extends Notifier<LoginFormState> {
  @override
  LoginFormState build() {
    return const LoginFormState();
  }

  void validateEmail(String email) {
    String? emailError;

    if (email.isEmpty) {
      emailError = 'Email is required';
    } else {
      final emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      );
      if (!emailRegex.hasMatch(email)) {
        emailError = 'Enter a valid email';
      }
    }
    final bool isValid = _calculateFormValidity(
      email: email,
      password: state.password,
      emailError: emailError,
      passwordError: state.passwordError,
    );

    state = state.copyWith(
      email: email,
      emailError: emailError,
      isValid: isValid,
    );
  }

  void validatePassword(String password) {
    String? passwordError;

    if (password.isEmpty) {
      passwordError = 'Password is required';
    } else if (password.length < 6) {
      passwordError =
          'Password must be atleast 6 characters';
    }

    final isValid = _calculateFormValidity(
      email: state.email,
      password: password,
      emailError: state.emailError,
      passwordError: passwordError,
    );

    state = state.copyWith(
      password: password,
      passwordError: passwordError,
      isValid: isValid,
    );
  }

  void setSubmitting(bool value) {
    state = state.copyWith(isSubmitting: value);
  }

  bool _calculateFormValidity({
    required String email,
    required String password,
    required String? emailError,
    required String? passwordError,
  }) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        emailError == null &&
        passwordError == null;
  }
}
