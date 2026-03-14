import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:p_papper/core/utils/app_snackbar.dart';
import 'package:p_papper/core/utils/custom_elevated_button.dart';
import 'package:p_papper/core/utils/custom_text.dart';
import 'package:p_papper/core/utils/custom_text_button.dart';
import 'package:p_papper/features/auth/presentation/provider/auth_notifier_provider.dart';
import 'package:p_papper/features/auth/presentation/provider/login_form_notifier_provider.dart';
import 'package:p_papper/features/auth/presentation/widgets/custom_text_form_field.dart';

class LogRegForm extends ConsumerStatefulWidget {
  const LogRegForm({super.key});

  @override
  ConsumerState<LogRegForm> createState() =>
      _LogRegFormState();
}

class _LogRegFormState extends ConsumerState<LogRegForm> {
  bool hasSubmitted = false;

  final _key = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Object? lastError;

    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null && previous?.value != user) {
            AppSnackbar.showSuccess(
              context,
              'Login successful',
            );
          }
        },
        error: (error, _) {
          if (lastError != error) {
            lastError = error;
            AppSnackbar.showError(
              context,
              error.toString(),
            );
          }
        },
      );
    });

    final asyncAuthState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(
      authNotifierProvider.notifier,
    );

    final formState = ref.watch(loginFormNotifierProvider);
    final formNotifier = ref.read(
      loginFormNotifierProvider.notifier,
    );

    final double buttonWidth = MediaQuery.of(
      context,
    ).size.width;

    return Form(
      key: _key,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
            errorText: formState.emailError,
            onChanged: (value) {
              if (hasSubmitted) {
                formNotifier.validateEmail(value);
              }
            },
            icon: Icons.email_rounded,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            errorText: formState.passwordError,
            onChanged: (value) {
              if (hasSubmitted) {
                formNotifier.validatePassword(value);
              }
            },
            icon: Icons.lock_rounded,
            labelText: 'Password',
            obscureText: true,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const CustomText(
                text: 'don\'t have an account?',
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomTextButton(
                  onPressed: () {
                    context.go('/register');
                  },
                  text: 'Sign up',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          CustomElevatedButton(
            onPressed: asyncAuthState.isLoading
                ? null
                : () {
                    setState(() {
                      hasSubmitted = true;
                    });
                    if (formNotifier.validateForm(
                      _emailController.text,
                      _passwordController.text,
                    )) {
                      authNotifier
                          .loginWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                    }
                  },
            bgColor: Colors.blue,
            elevation: 1.5,
            fixedSize: Size(buttonWidth * 0.92, 53),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(
                5,
              ),
            ),
            child: asyncAuthState.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const CustomText(
                    text: 'login',
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
          ),
        ],
      ),
    );
  }
}
