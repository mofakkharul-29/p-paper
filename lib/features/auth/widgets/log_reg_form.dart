import 'package:flutter/material.dart';
import 'package:p_papper/core/utils/custom_elevated_button.dart';
import 'package:p_papper/core/utils/custom_text.dart';
import 'package:p_papper/core/utils/custom_text_button.dart';
import 'package:p_papper/features/auth/widgets/custom_text_form_field.dart';

class LogRegForm extends StatelessWidget {
  const LogRegForm({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    final double buttonWidth = MediaQuery.of(
      context,
    ).size.width;

    return Form(
      key: key,
      child: Column(
        children: [
          const CustomTextFormField(
            icon: Icons.email_rounded,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          const CustomTextFormField(
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
                    debugPrint('pressed');
                  },
                  text: 'Sign up',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          CustomElevatedButton(
            onPressed: () {},
            bgColor: Colors.blue,
            elevation: 1.5,
            fixedSize: Size(buttonWidth * 0.92, 53),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(
                5,
              ),
            ),
            child: const CustomText(
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
