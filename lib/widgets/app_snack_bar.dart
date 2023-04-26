// flutter
import 'package:flutter/material.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

snackBarApp({
  required BuildContext context,
  String? text,
  Color? color,
  Color? textColor,
  double? fontSize,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ?? snackBarDefaultColor,
      content: Text(
        text ?? 'Por favor, aguarde ...',
        style: TextStyle(
          color: textColor ?? whiteColor,
          fontSize: fontSize ?? scaleHeight * 13,
        ),
      ),
      duration: const Duration(milliseconds: 1000),
    ),
  );
}
