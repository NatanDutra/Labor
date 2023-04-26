// flutter
import 'package:flutter/material.dart';

// utils
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class TitleRegister extends StatelessWidget {
  const TitleRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Crie sua conta',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: scaleHeight * 24,
            letterSpacing: scaleHeight * 0.5,
          ),
        ),
        sh(15),
        Text(
          'Preencha os campos com as informações para criar sua conta.',
          style: TextStyle(
            fontSize: scaleHeight * 14,
            color: blackColor.withOpacity(0.6),
            fontWeight: FontWeight.w400,
            letterSpacing: scaleHeight * 0.65,
          ),
        ),
      ],
    );
  }
}
