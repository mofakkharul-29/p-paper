import 'package:flutter/material.dart';
import 'package:p_papper/features/auth/widgets/custom_text_form_field.dart';

class LogRegForm extends StatelessWidget {
  const LogRegForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            icon: Icons.email_rounded,
            labelText: 'Email',
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            icon: Icons.person_rounded,
            labelText: 'Name',
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            icon: Icons.lock_rounded,
            labelText: 'Password',
          ),
        ],
      ),
    );
  }
}
