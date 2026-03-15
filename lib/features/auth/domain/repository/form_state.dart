class LoginFormState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isSubmitting;
  final bool isValid;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isSubmitting = false,
    this.isValid = false,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    Object? emailError = _noChange,
    Object? passwordError = _noChange,
    bool? isSubmitting,
    bool? isValid,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError == _noChange
          ? this.emailError
          : emailError as String?,
      passwordError: passwordError == _noChange
          ? this.passwordError
          : passwordError as String?,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isValid: isValid ?? this.isValid,
    );
  }

  static const _noChange = Object();
}
