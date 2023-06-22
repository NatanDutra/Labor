// flutter
// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

// firebase
// import 'package:firebase_auth/firebase_auth.dart';

// screen
import './screens/login/login_screen.dart';

// utils
import './utils/size_config.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthWidget> createState() {
    return _AuthWidgetState();
  }
}

class _AuthWidgetState extends State<AuthWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(
      milliseconds: 2000,
    ),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    _checkState();
  }

  _checkState() async {
    _controller.animateTo(
      1,
      curve: Curves.easeInCirc,
    );

    await Future.delayed(
      const Duration(
        milliseconds: 2800,
      ),
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
    
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: scaleWidth * 180,
          horizontal: scaleHeight * 80,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/splash.png",
            ),
            fit: BoxFit.cover,
          ),
        ),

        child: FadeTransition(
          opacity: _controller,
          child: Image.asset(
            'assets/images/logoredonda.png',
          ),
        ),
      ),
    );
  }
}
