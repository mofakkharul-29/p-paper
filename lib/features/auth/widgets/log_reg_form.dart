import 'package:flutter/material.dart';
import 'package:p_papper/core/utils/custom_elevated_button.dart';
import 'package:p_papper/core/utils/custom_text.dart';
import 'package:p_papper/features/auth/widgets/custom_text_form_field.dart';

class LogRegForm extends StatelessWidget {
  const LogRegForm({super.key});

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(
      context,
    ).size.width;

    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            icon: Icons.email_rounded,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            icon: Icons.lock_rounded,
            labelText: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 15),
          CustomElevatedButton(
            onPressed: () {},
            bgColor: Colors.blue,
            elevation: 1.5,
            fixedSize: Size(buttonWidth * 0.92, 53),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(5),
            ),
            child: CustomText(
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
