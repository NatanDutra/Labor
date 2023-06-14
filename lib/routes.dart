import 'package:flutter/material.dart';
import 'package:labor/screens/contractor/contractor_screen.dart';
import 'package:labor/screens/login/login_screen.dart';
import 'package:labor/screens/register/register_screen.dart';
import 'package:labor/screens/serviceProvider/screen_service_provider.dart';
import 'package:labor/screens/serviceProvider/widget/screen_accept_service.dart';


class Rotas {
  static Route<dynamic> generateRoutes(RouteSettings settings) {

    switch (settings.name){
      case '/' :
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register' :
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/service-provider' :
        return MaterialPageRoute(builder: (_) => const ServiceProviderScreen());
      case '/contractor' :
        return MaterialPageRoute(builder: (_) => const ContractorScreen());
      default: 
        return _erroRota();
    }
  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Tela não encontrada')),
        body: const Center(
          child: Text('Tela não encontrada'),
        ),
      );
    }
  );
  }
}