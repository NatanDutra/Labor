// flutter
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// utils
import '../../model/usuario.dart';
import '../../utils/colors.dart';
import '../../utils/size_config.dart';
import '../../utils/validations.dart';

// widgets
import '../../widgets/app_button.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/app_snack_bar.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/app_load_spinner.dart';

// widget login
import './widget/title_login.dart';
import './widget/forgot_password_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailError = false;
  bool _isEmailTypeError = false;

  final TextEditingController _pwdController = TextEditingController();
  bool _isPwdError = false;
  bool _isPwdTypeError = false;

  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
    _verifyUserLogged();
  }

  Future _verifyUserLogged() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    
    var userLogged = auth.currentUser;
    if(userLogged != null){
      String idUser = userLogged.uid;
      _redirectScreenPerTypeUser(idUser);
    }
  }

  _logarUsuario(Usuario usuario){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(email: usuario.email, password: usuario.password).then((firebaseUser) {
      setState(() {
          _isLoading = false;
        });
      LoadSpinner().hide();
      _redirectScreenPerTypeUser(firebaseUser.user!.uid);
    }).catchError((error){
      setState(() {
          _isLoading = false;
        });
      LoadSpinner().hide();
      dialogBoxImageApp(
          context: context,
          title: "",
          msg: 'Email ou senha inválidos!',
          image: 'assets/images/createdAccount.png',
        );
    });
  }

  _redirectScreenPerTypeUser(String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance; 
    DocumentSnapshot snapshot = await db.collection("usuarios")
    .doc(userId).get();

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String tipoUsuario = data['tipoUsuario'];
    if(tipoUsuario == 'serviceProvider'){
      Navigator.pushReplacementNamed(context, '/service-provider');
    } else if(tipoUsuario == 'contractor'){
      Navigator.pushReplacementNamed(context, '/contractor');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // final _authService = Provider.of<AuthService>(context);

    login() async {
      try {
        
        Usuario usuario = Usuario();
        usuario.email = _emailController.text.trim();
        usuario.password = _pwdController.text.trim();


        await _logarUsuario(usuario);
        
        
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        LoadSpinner().hide();

        await dialogBoxAppDialog(
          context: context,
          title: "",
          msg: error.toString(),
        );
      }
    }

    return WillPopScope(
      onWillPop: () async {
        if (_isLoading) {
          snackBarApp(context: context);
        }
        return !_isLoading;
      },
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(
                horizontal: scaleWidth * 28,
                vertical: scaleHeight * 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sh(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleLogin(),
                      AppTextFieldIcon(
                        label: 'E-mail *',
                        controller: _emailController,
                        hint: 'Digite seu e-mail',
                        input: 'email',
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.emailAddress,
                        icon: Icons.markunread,
                        error: _isEmailError,
                        typeError: _isEmailTypeError,
                        errorText: '** Por favor, insira um e-mail válido',
                        onChanged: (val) {
                          final result = validation(
                            val.trim(),
                            'email',
                          );

                          setState(() {
                            _isEmailError = result.hasError;
                            _isEmailTypeError = result.hasError2;
                          });

                          return null;
                        },
                      ),
                      sh(15),
                      AppTextFieldIcon(
                        label: 'Senha *',
                        controller: _pwdController,
                        hint: '********',
                        input: 'password',
                        textInputAction: TextInputAction.done,
                        icon: Icons.lock,
                        error: _isPwdError,
                        typeError: _isPwdTypeError,
                        errorText:
                            '** Senha deve conter uma letra maiúscula, uma letra minúscula, um número, um caractere especial e 8 dígitos',
                        onChanged: (val) {
                          final result = validation(
                            val.trim(),
                            'password',
                          );

                          setState(() {
                            _isPwdError = result.hasError;
                            _isPwdTypeError = result.hasError2;
                          });

                          return null;
                        },
                      ),
                      sh(25),
                      const ForgotPasswordButton(),
                      sh(28),
                      AppButton(
                        label: 'Começar',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          if (_emailController.text.trim() != '' &&
                              _pwdController.text.trim() != '') {
                            if (_isEmailError == false &&
                                _isPwdError == false) {
                              await login();
                            } else {
                              await dialogBoxAppDialog(
                                context: context,
                                title: "",
                                msg: 'Por favor, corrija os campos marcados',
                              );
                            }
                          } else {
                            setState(() {
                              if (_emailController.text.trim() == '') {
                                _isEmailError = true;
                              }
                              if (_pwdController.text.trim() == '') {
                                _isPwdError = true;
                              }
                            });

                            await dialogBoxAppDialog(
                              context: context,
                              title: '',
                              msg: 'Por favor, corrija os campos marcados',
                            );
                          }
                        },
                      ),
                      sh(50),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: scaleWidth * 10),
                              height: 1,
                              color: blackColor,
                            ),
                          ),
                          Text(
                            "OU",
                            style: TextStyle(
                              fontSize: scaleWidth * 12,
                              color: blackColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: scaleWidth * 10),
                              height: 1,
                              color: blackColor,
                            ),
                          ),
                        ],
                      ),
                      sh(18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Não tem conta?',
                            style: TextStyle(
                              fontSize: scaleWidth * 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              ' Inscrever-se',
                              style: TextStyle(
                                fontSize: scaleWidth * 14,
                                fontWeight: FontWeight.w700,
                                color: blueColor2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
