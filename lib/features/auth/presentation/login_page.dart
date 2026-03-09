import 'package:flutter/material.dart';
import 'package:p_papper/core/utils/body_container.dart';
import 'package:p_papper/features/auth/widgets/log_reg_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BodyContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LogRegForm(),
                      const SizedBox(height: 20),
                      Text('login options'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
