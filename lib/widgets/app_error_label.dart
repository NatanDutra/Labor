// flutter
import 'package:flutter/material.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class AppErrorLabel extends StatelessWidget {
  const AppErrorLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: scaleHeight * 48,
      decoration: const BoxDecoration(
        color: backgroundColor,
      ),
      child: Icon(
        Icons.error,
        color: redColor,
        size: scaleHeight * 25,
      ),
    );
  }
}
