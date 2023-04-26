// flutter
import 'package:flutter/material.dart';

// utils
import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

// staticScreens
// import '../../../screens/privacyPolicy/privacyPolicyScreen.dart';
// import '../../../screens/termsConditions/termsConditionsScreen.dart';

class CheckBoxTerms extends StatelessWidget {
  const CheckBoxTerms({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: scaleHeight * 1,
            child: Checkbox(
              side: BorderSide(
                color: grayColor,
                width: scaleWidth * 1,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              activeColor: primaryColor,
              checkColor: whiteColor,
              value: value,
              onChanged: (bool? newValue) async {
                onChanged(newValue!);
              },
            ),
          ),
          sb(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Eu concordo com os ',
                    style: TextStyle(
                      fontSize: scaleHeight * 13,
                      color: blackColor,
                    ),
                  ),
                  sb(3),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (_) => TermsScreen(),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Termos e Condições',
                      style: TextStyle(
                        fontSize: scaleHeight * 13,
                        fontWeight: FontWeight.w700,
                        color: blackColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              sh(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'e ',
                    style: TextStyle(
                      fontSize: scaleHeight * 13,
                      color: blackColor,
                    ),
                  ),
                  sb(3),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (_) => PrivacyPolicyScreen(),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Política de Privacidade',
                      style: TextStyle(
                        fontSize: scaleHeight * 13,
                        fontWeight: FontWeight.w700,
                        color: blackColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
