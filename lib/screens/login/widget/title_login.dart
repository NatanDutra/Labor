// flutter
import 'package:flutter/material.dart';

// utils
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class TitleLogin extends StatelessWidget {
  const TitleLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sh(25),
        Text(
          'Bem-vindo de volta a',
          style: TextStyle(
            fontSize: scaleHeight * 20,
            fontWeight: FontWeight.w600,
            letterSpacing: scaleHeight * 0.65,
            color: blackColor,
          ),
        ),
        Text(
          'Labor',
          style: TextStyle(
            fontSize: scaleHeight * 24,
            fontWeight: FontWeight.w600,
            letterSpacing: scaleHeight * 0.65,
            color: blueColor2,
          ),
        ),
        sh(16),
        Text(
          'Insira seus dados para começar.',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: scaleHeight * 14,
            color: blackColor.withOpacity(0.6),
            fontWeight: FontWeight.w400,
            letterSpacing: scaleHeight * 0.65,
          ),
        ),
        sh(25),
      ],
    );
  }
}
