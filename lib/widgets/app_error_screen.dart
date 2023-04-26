// flutter
import 'package:flutter/material.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

// widgets
import '../../widgets/app_button.dart';

class ErrorStatic extends StatelessWidget {
  const ErrorStatic({
    Key? key,
    @required this.nav,
  }) : super(key: key);

  final bool? nav;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        color: whiteColor,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: redColor,
                  size: scaleHeight * 80,
                ),
                sh(20),
                Center(
                  child: Text(
                    'Desculpe, ocorreu um erro ao carregar seus dados.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: scaleHeight * 14,
                    ),
                  ),
                ),
                sh(30),
                AppHeightButton(
                  width: scaleWidth * 135,
                  height: scaleHeight * 38,
                  fontSize: scaleHeight * 13,
                  color: primaryColor,
                  label: 'Voltar',
                  onPressed: () async => {
                    // nav == true
                    //     ? Navigator.of(context).pushReplacement(
                    //         MaterialPageRoute(
                    //           builder: (context) => HomeMain(change: 0),
                    //         ),
                    //       )
                    // :
                    Navigator.of(context).pop(),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
