class LoginFormState {
  final String email;
  final String password;
  final String name;

  final String? emailError;
  final String? passwordError;
  final String? nameError;
  
  final bool isSubmitting;
  final bool isValid;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.emailError,
    this.passwordError,
    this.nameError,
    this.isSubmitting = false,
    this.isValid = false,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    String? name,
    Object? emailError = _noChange,
    Object? passwordError = _noChange,
    Object? nameError = _noChange,
    bool? isSubmitting,
    bool? isValid,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      emailError: emailError == _noChange
          ? this.emailError
          : emailError as String?,
      passwordError: passwordError == _noChange
          ? this.passwordError
          : passwordError as String?,
      nameError: nameError == _noChange
          ? this.nameError
          : nameError as String?,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isValid: isValid ?? this.isValid,
    );
  }

  static const _noChange = Object();
}
