// flutter
import 'package:flutter/material.dart';

// screen
import 'package:labor/screens/forgotPassword/forgot_password_screen.dart';
// utils
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ForgotPasswordScreen(),
            ),
          );
        },
        child: Text(
          'Esqueci minha senha',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: blackColor,
            decoration: TextDecoration.underline,
            fontSize: scaleHeight * 13,
          ),
        ),
      ),
    );
  }
}
