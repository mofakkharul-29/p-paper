import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/auth/domain/repository/form_state.dart';

class LoginFormNotifier extends Notifier<LoginFormState> {
  @override
  LoginFormState build() {
    return const LoginFormState();
  }

  void validateEmail(String email) {
    final String? emailError = _validateEmail(email);

    state = state.copyWith(
      email: email,
      emailError: emailError,
      isValid: _isFormValid(
        emailError: emailError,
        passwordError: state.passwordError,
      ),
    );
  }

  void validatePassword(String password) {
    final String? passwordError = _validatePassword(
      password,
    );

    state = state.copyWith(
      password: password,
      passwordError: passwordError,
      isValid: _isFormValid(
        emailError: state.emailError,
        passwordError: passwordError,
      ),
    );
  }

  bool validateForm(String email, String password) {
    final String? emailError = _validateEmail(email);
    final String? passwordError = _validatePassword(
      password,
    );

    final isValid = _isFormValid(
      emailError: emailError,
      passwordError: passwordError,
    );

    state = state.copyWith(
      email: email,
      password: password,
      emailError: emailError,
      passwordError: passwordError,
      isValid: isValid,
    );

    return isValid;
  }

  void setSubmitting(bool value) {
    state = state.copyWith(isSubmitting: value);
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    } else {
      final emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      );
      if (!emailRegex.hasMatch(email)) {
        return 'Enter a valid email';
      }
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  bool _isFormValid({
    required String? emailError,
    required String? passwordError,
  }) {
    return emailError == null && passwordError == null;
  }
}
