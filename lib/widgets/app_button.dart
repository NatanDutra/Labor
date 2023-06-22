// flutter
import 'package:flutter/material.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    @override required this.onPressed,
    this.label,
    this.width,
    this.height,
    this.border = false,
    this.fontSize,
    this.color,
    this.textColor,
    this.icon,
  }) : super(key: key);

  final void Function()? onPressed;
  final String? label;
  final double? width;
  final double? height;
  final bool? border;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: width ?? SizeConfig.screenWidth,
      height: height ?? scaleHeight * 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color ?? blueColor2,
          side: BorderSide(
            width: border == true ? scaleHeight * 2.5 : 0,
            color: border == true ? primaryColor : transparent,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Container(
                    margin: EdgeInsets.only(
                      right: scaleWidth * 12,
                    ),
                    child: Icon(
                      icon,
                      color: blackColor,
                      size: scaleHeight * 25,
                    ),
                  )
                : sb(0),
            label != null
                ? Text(
                    label!,
                    style: TextStyle(
                      color: textColor ?? blackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: fontSize ?? scaleWidth * 14,
                    ),
                  )
                : sb(0),
          ],
        ),
      ),
    );
  }
}

class AppButtonTransparent extends StatelessWidget {
  const AppButtonTransparent({
    super.key,
    @override required this.onPressed,
    this.label,
    this.width,
    this.height,
    this.border = false,
    this.fontSize,
    this.color,
    this.textColor,
    this.icon,
  });

  final void Function()? onPressed;
  final String? label;
  final double? width;
  final double? height;
  final bool? border;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: width ?? SizeConfig.screenWidth,
      height: height ?? scaleHeight * 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: scaleHeight * 2.5,
            color: primaryColor,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Container(
                    margin: EdgeInsets.only(
                      right: scaleWidth * 12,
                    ),
                    child: icon,
                  )
                : sb(0),
            label != null
                ? Text(
                    label!,
                    style: TextStyle(
                      color: textColor ?? primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: fontSize ?? scaleWidth * 14,
                    ),
                  )
                : sb(0),
          ],
        ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    @override required this.onPressed,
    this.width,
    this.color,
    this.icon,
  });

  final void Function()? onPressed;
  final double? width;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SizedBox(
      width: width ?? SizeConfig.screenWidth,
      height: scaleHeight * 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color ?? primaryColor,
        ),
        onPressed: onPressed,
        child: icon != null
            ? Icon(
                icon,
                color: blackColor,
                size: scaleHeight * 25,
              )
            : sb(0),
      ),
    );
  }
}

class AppHeightButton extends StatelessWidget {
  const AppHeightButton({
    super.key,
    @override required this.onPressed,
    this.label,
    this.width,
    this.height,
    this.fontSize,
    this.color,
    this.textColor,
  });

  final void Function()? onPressed;
  final String? label;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? SizeConfig.screenWidth,
        height: height ?? scaleHeight * 50,
        decoration: BoxDecoration(
          color: color ?? whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(scaleHeight * 4),
          ),
          border: Border.all(
            width: scaleHeight * 2.5,
            color: color ?? whiteColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label!,
              style: TextStyle(
                color: textColor ?? blackColor,
                fontWeight: FontWeight.w700,
                fontSize: fontSize ?? scaleWidth * 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
