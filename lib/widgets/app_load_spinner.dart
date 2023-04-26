import 'package:flutter/material.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

typedef CloseLoadSpinner = bool Function();

@immutable
class LoadSpinnerController {
  final CloseLoadSpinner close;

  const LoadSpinnerController({
    required this.close,
  });
}

class LoadSpinner {
  factory LoadSpinner() => _shared;
  static final LoadSpinner _shared = LoadSpinner._sharedInstance();

  LoadSpinner._sharedInstance();

  LoadSpinnerController? controller;

  void show({
    required BuildContext context,
  }) {
    controller = showOverlay(
      context: context,
    );
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadSpinnerController showOverlay({
    required BuildContext context,
  }) {
    final state = Overlay.of(context);

    final overlay = OverlayEntry(
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Material(
            color: blackColor.withAlpha(180),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: primaryColor,
                    ),
                    sh(16),
                    Text(
                      'Por favor, aguarde ...',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: scaleHeight * 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadSpinnerController(
      close: () {
        overlay.remove();
        return true;
      },
    );
  }
}

class LoadStatic extends StatelessWidget {
  const LoadStatic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        color: blackColor.withAlpha(180),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: primaryColor,
                ),
                sh(16),
                Text(
                  'Por favor, aguarde ...',
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: scaleHeight * 14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
