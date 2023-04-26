// flutter
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

// widget
import '../../widgets/app_button.dart';
import '../../widgets/app_load_spinner.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    Key? key,
    required this.title,
    required this.msg,
  }) : super(key: key);

  final String title;
  final String msg;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: scaleWidth * 15,
      ),
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          scaleWidth * 4,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: scaleWidth * 16,
          vertical: scaleHeight * 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sh(8),
            title != ''
                ? Text(
                    title,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: scaleHeight * 15,
                      color: blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : sh(0),
            title != "" ? sh(20) : sh(12),
            Text(
              msg,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: scaleHeight * 13,
                color: blackColor,
              ),
            ),
            sh(24),
            AppHeightButton(
              label: 'OK',
              width: scaleWidth * 120,
              height: scaleHeight * 40,
              fontSize: scaleHeight * 14,
              color: primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

dialogBoxAppDialog({
  required BuildContext context,
  required String msg,
  required String title,
}) async {
  await showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: blackColor.withOpacity(0.5),
    builder: (BuildContext context) {
      return AppDialog(
        title: title,
        msg: msg,
      );
    },
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 300),
  );
}

class AppImageDialog extends StatelessWidget {
  final String msg;
  final String? image;
  final String? svg;
  final String title;

  const AppImageDialog({
    Key? key,
    required this.msg,
    this.image,
    this.svg,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: scaleWidth * 15,
      ),
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          scaleWidth * 4,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: scaleWidth * 16,
          vertical: scaleHeight * 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sh(8),
            image != null
                ? Image.asset(
                    image!,
                    height: scaleHeight * 180,
                  )
                : sh(0),
            svg != null
                ? SvgPicture.asset(
                    svg!,
                    width: scaleHeight * 180,
                    height: scaleHeight * 180,
                  )
                : sh(0),
            sh(20),
            title != ""
                ? Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: scaleHeight * 24,
                      fontWeight: FontWeight.w700,
                      color: blackColor,
                    ),
                  )
                : sh(0),
            title != "" ? sh(8) : sh(0),
            Text(
              msg,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: scaleHeight * 14,
                color: blackColor,
              ),
            ),
            sh(20),
            AppHeightButton(
              label: 'OK',
              width: scaleWidth * 120,
              height: scaleHeight * 40,
              fontSize: scaleHeight * 14,
              color: primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

dialogBoxImageApp({
  required BuildContext context,
  required String msg,
  String? image,
  String? svg,
  required String title,
}) async {
  await showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: blackColor.withOpacity(0.5),
    builder: (BuildContext context) {
      return AppImageDialog(
        msg: msg,
        image: image,
        svg: svg,
        title: title,
      );
    },
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 300),
  );
}

class AppLogOutDialog extends StatefulWidget {
  const AppLogOutDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AppLogOutDialog> createState() => _AppLogOutDialogState();
}

class _AppLogOutDialogState extends State<AppLogOutDialog> {
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // final authService = Provider.of<AuthService>(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: scaleWidth * 30,
      ),
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          scaleWidth * 4,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: scaleWidth * 16,
          vertical: scaleHeight * 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sh(10),
            Text(
              'Deseja mesmo sair do aplicativo?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: scaleHeight * 14,
              ),
            ),
            sh(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButtonTransparent(
                  label: 'Cancelar',
                  width: scaleWidth * 120,
                  textColor: blackColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                sb(25),
                AppButton(
                  label: 'OK',
                  width: scaleWidth * 120,
                  border: true,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    LoadSpinner().show(
                      context: context,
                    );

                    try {
                      setState(() {
                        isLoading = false;
                      });
                      LoadSpinner().hide();

                      // await authService.signOut();

                      // Navigator.of(context).pushAndRemoveUntil(
                      //   MaterialPageRoute(
                      //     builder: (context) => HomeMain(),
                      //   ),
                      //   (route) => false,
                      // );
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      LoadSpinner().hide();

                      await dialogBoxAppDialog(
                        context: context,
                        title: "",
                        msg: e.toString(),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

dialogBoxLogoutApp({
  required BuildContext context,
}) async {
  await showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: blackColor.withOpacity(0.4),
    builder: (BuildContext context) {
      return const AppLogOutDialog();
    },
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 300),
  );
}

class AppCancelOkDialog extends StatefulWidget {
  const AppCancelOkDialog({
    Key? key,
    required this.msg,
    required this.cancelPress,
    required this.okPress,
  }) : super(key: key);

  final String msg;
  final Function() cancelPress;
  final Function() okPress;

  @override
  State<AppCancelOkDialog> createState() => _AppCancelOkDialogState();
}

class _AppCancelOkDialogState extends State<AppCancelOkDialog> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: scaleWidth * 30,
      ),
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          scaleWidth * 4,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: scaleWidth * 16,
          vertical: scaleHeight * 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sh(10),
            Text(
              widget.msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: scaleHeight * 14,
              ),
            ),
            sh(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButtonTransparent(
                  label: 'Cancel',
                  width: scaleWidth * 120,
                  textColor: blackColor,
                  onPressed: widget.cancelPress,
                ),
                sb(25),
                AppButton(
                  label: 'OK',
                  width: scaleWidth * 120,
                  border: true,
                  onPressed: widget.okPress,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

dialogBoxCancelOk({
  required BuildContext context,
  required String msg,
  required Function() cancelPress,
  required Function() okPress,
}) async {
  await showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: blackColor.withOpacity(0.4),
    builder: (BuildContext context) {
      return AppCancelOkDialog(
        msg: msg,
        cancelPress: cancelPress,
        okPress: okPress,
      );
    },
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 300),
  );
}
