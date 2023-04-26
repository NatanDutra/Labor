// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labor/routes.dart';
import 'dart:io';
// import 'package:provider/provider.dart';

// screen
import './auth_widget.dart';

import './utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid || Platform.isIOS){
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        title: 'Labor',
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          fontFamily: 'Poppins',
        ),
        initialRoute: '/',
        onGenerateRoute: Rotas.generateRoutes,
        home: const AuthWidget(),
      ),
    );
  }
}
