// flutter
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';
import '../../utils/validations.dart';

// widgets
import '../../widgets/app_button.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/app_top_bar.dart';
import '../../widgets/app_snack_bar.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/app_load_spinner.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailError = false;
  bool _isEmailTypeError = false;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // final _authService = Provider.of<AuthService>(context);

    forgotPassword() async {
      setState(() {
        _isLoading = true;
      });
      LoadSpinner().show(
        context: context,
      );

      try {
        // await _authService.sendPasswordResetEmail(
        //   _emailController.text.trim(),
        // );

        setState(() {
          _isLoading = false;
        });
        LoadSpinner().hide();

        await dialogBoxImageApp(
          context: context,
          title: "",
          msg: 'O link de redefinição de senha foi enviado para seu e-mail.',
          image: 'assets/images/envelope.png',
        );

        if (context.mounted) {
          Navigator.of(context).pop();
        }
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
        backgroundColor: backgroundColor,
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
                children: [
                  const TopBarNotLogged(),
                  sh(40),
                  Text(
                    'Alterar Senha',
                    style: TextStyle(
                      fontSize: scaleHeight * 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: scaleHeight * 0.65,
                      color: blackColor,
                    ),
                  ),
                  sh(15),
                  Text(
                    'Insira o e-mail vinculado a conta para redefinir sua senha.',
                    style: TextStyle(
                      fontSize: scaleHeight * 14,
                      color: blackColor.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                      letterSpacing: scaleHeight * 0.65,
                    ),
                  ),
                  sh(60),
                  AppTextFieldIcon(
                    label: 'E-mail',
                    controller: _emailController,
                    hint: 'Digite seu e-mail',
                    input: 'email',
                    inputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
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
                  sh(35),
                  AppButton(
                    label: 'Enviar',
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (_emailController.text.trim() != '') {
                        if (_isEmailError == false) {
                          await forgotPassword();
                        } else {
                          await dialogBoxAppDialog(
                            context: context,
                            title: "",
                            msg: 'Por favor, corrija os campos marcados',
                          );
                        }
                      } else {
                        setState(() {
                          _isEmailError = true;
                        });

                        await dialogBoxAppDialog(
                          context: context,
                          title: "",
                          msg: 'Por favor, corrija os campos marcados',
                        );
                      }
                    },
                  ),
                  sh(50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
