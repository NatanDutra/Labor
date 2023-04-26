// flutter
import 'package:flutter/material.dart';
import 'package:labor/model/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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

// widget register
import './widget/check_box_terms.dart';
import './widget/title_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isNameError = false;
  bool _isNameTypeError = false;

  final TextEditingController _emailController = TextEditingController();
  bool _isEmailError = false;
  bool _isEmailTypeError = false;

  final TextEditingController _cpfController = TextEditingController();
  bool _isCpfError = false;
  bool _isCpfTypeError = false;

  final TextEditingController _phoneController = TextEditingController();
  bool _isPhoneError = false;
  bool _isPhoneTypeError = false;

  final TextEditingController _pwdController = TextEditingController();
  bool _isPwdError = false;
  bool _isPwdTypeError = false;
  final FocusNode _pwdFocus = FocusNode();

  final TextEditingController _confPwdController = TextEditingController();
  bool _isConfPwdError = false;
  bool _isConfPwdTypeError = false;
  final FocusNode _confPwdFocus = FocusNode();

  bool _terms = false;
  bool _tipoUsuario = false;
  bool _isLoading = false;
  _registerUser(Usuario usuario){
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    auth.createUserWithEmailAndPassword(email: usuario.email, password: usuario.password).then((firebaseUser) {
      db.collection('usuarios').doc(firebaseUser.user?.uid).set(usuario.toMap());
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    register() async {
      setState(() {
        _isLoading = true;
      });
      LoadSpinner().show(
        context: context,
      );
      
        try {

          Usuario usuario = Usuario();
          usuario.nome = _nameController.text.trim();
          usuario.email = _emailController.text.trim();
          usuario.password = _pwdController.text.trim();
          usuario.tipoUsuario = usuario.verificaTipoUsuario(_tipoUsuario);

          await _registerUser(usuario);

          setState(() {
            _isLoading = false;
          });
          LoadSpinner().hide();

            await dialogBoxImageApp(
              context: context,
              title: "",
              msg: 'Sua conta foi criada com sucesso!',
              image: 'assets/images/createdAccount.png',
          );
          
          
          switch(usuario.tipoUsuario){
              case "serviceProvider" :
                Navigator.pushNamedAndRemoveUntil(context, '/service-provider', (_) => false);
                break;
              case "contractor" :
                Navigator.pushNamedAndRemoveUntil(context, '/contractor', (_) => false);
                break;
              default: Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          }
          // Navigator.of(context).pushAndRemoveUntil(
          //   MaterialPageRoute(
          //     builder: (context) => HomeMain(),
          //   ),
          //   (route) => false,
          // );
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TopBarNotLogged(),
                  sh(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleRegister(),
                      sh(50),
                      Row(children: <Widget>[
                        const Text('Contratante'),
                        Switch(value: _tipoUsuario, onChanged: (bool value) {
                          setState(() {
                            _tipoUsuario = value;
                          });
                        }),
                        const Text('Prestador de Serviço'),
                      ],),
                      AppTextFieldIcon(
                        label: 'Nome completo',
                        controller: _nameController,
                        hint: 'Digite nome completo',
                        input: 'name',
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        inputType: TextInputType.text,
                        icon: Icons.person,
                        error: _isNameError,
                        typeError: _isNameTypeError,
                        errorText: '** Insira seu nome e sobrenome',
                        onChanged: (val) {
                          final result = validation(
                            val.trim(),
                            'name',
                          );

                          setState(() {
                            _isNameError = result.hasError;
                            _isNameTypeError = result.hasError2;
                          });
                          return null;
                        },
                      ),
                      sh(20),
                      AppTextFieldIcon(
                        label: 'E-mail',
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
                      sh(20),
                      AppTextFieldIcon(
                        label: 'CPF',
                        controller: _cpfController,
                        hint: '###.###.###-##',
                        input: 'cpf',
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.number,
                        icon: Icons.badge,
                        error: _isCpfError,
                        typeError: _isCpfTypeError,
                        errorText: '** Insira um CPF válido',
                        onChanged: (val) {
                          final result = validation(
                            val.trim(),
                            'cpf',
                          );

                          setState(() {
                            _isCpfError = result.hasError;
                            _isCpfTypeError = result.hasError2;
                          });
                          return null;
                        },
                      ),
                      sh(20),
                      AppTextFieldIcon(
                        label: 'Telefone celular',
                        controller: _phoneController,
                        hint: '## #####-####',
                        input: 'phone',
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.number,
                        icon: Icons.local_phone,
                        error: _isPhoneError,
                        typeError: _isPhoneTypeError,
                        errorText:
                            '** Insira um número de telefone celular válido',
                        onChanged: (val) {
                          final result = validation(
                            val.trim(),
                            'phone',
                          );

                          setState(() {
                            _isPhoneError = result.hasError;
                            _isPhoneTypeError = result.hasError2;
                          });
                          return null;
                        },
                      ),
                      sh(20),
                      AppTextFieldIcon(
                        label: 'Senha',
                        controller: _pwdController,
                        hint: '********',
                        input: 'password',
                        textInputAction: TextInputAction.next,
                        icon: Icons.lock,
                        error: _isPwdError,
                        typeError: _isPwdTypeError,
                        errorText:
                            '** Senha deve conter uma letra maiúscula, uma letra minúscula, um número, um caractere especial e 8 dígitos',
                        focusNode: _pwdFocus,
                        onFieldSubmitted: (next) {
                          _fieldFocusChange(context, _pwdFocus, _confPwdFocus);
                        },
                        onChanged: (val) {
                          if (_confPwdController.text.trim() !=
                              _pwdController.text.trim()) {
                            setState(() {
                              _isConfPwdError = true;
                              _isConfPwdTypeError = true;
                            });
                          } else {
                            _isConfPwdError = false;
                            _isConfPwdTypeError = false;
                          }

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
                      sh(20),
                      AppTextFieldIcon(
                        label: 'Confirme a Senha',
                        controller: _confPwdController,
                        hint: '********',
                        input: 'password',
                        textInputAction: TextInputAction.done,
                        icon: Icons.lock,
                        error: _isConfPwdError,
                        typeError: _isConfPwdTypeError,
                        errorText: '** As senhas não se correspondem',
                        focusNode: _confPwdFocus,
                        onFieldSubmitted: (value) {
                          _confPwdFocus.unfocus();
                        },
                        onChanged: (val) {
                          if (_confPwdController.text.trim() !=
                              _pwdController.text.trim()) {
                            setState(() {
                              _isConfPwdError = true;
                              _isConfPwdTypeError = true;
                            });
                          } else {
                            final result = emptyValidation(val.trim());

                            setState(() {
                              _isConfPwdError = result.hasError;
                              _isConfPwdTypeError = false;
                            });
                          }
                          return null;
                        },
                      ),
                      sh(30),
                      CheckBoxTerms(
                        value: _terms,
                        onChanged: (bool newValue) {
                          setState(() {
                            _terms = newValue;
                          });
                        },
                      ),
                      sh(35),
                      AppButton(
                        label: 'Registrar',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          if (_terms == true) {
                            if (_confPwdController.text.trim() ==
                                _pwdController.text.trim()) {
                              if (_nameController.text.trim() != '' &&
                                  _emailController.text.trim() != '' &&
                                  _cpfController.text.trim() != '' &&
                                  _phoneController.text.trim() != '' &&
                                  _pwdController.text.trim() != '' &&
                                  _confPwdController.text.trim() != '') {
                                if (_isNameError == false &&
                                    _isEmailError == false &&
                                    _isCpfError == false &&
                                    _isPhoneError == false &&
                                    _isPwdError == false &&
                                    _isConfPwdError == false) {
                                  register();
                                } else {
                                  await dialogBoxAppDialog(
                                    context: context,
                                    title: "",
                                    msg:
                                        'Por favor, corrija os campos marcados',
                                  );
                                }
                              } else {
                                setState(() {
                                  if (_nameController.text.trim() == '') {
                                    _isNameError = true;
                                  }
                                  if (_emailController.text.trim() == '') {
                                    _isEmailError = true;
                                  }
                                  if (_cpfController.text.trim() == '') {
                                    _isCpfError = true;
                                  }
                                  if (_phoneController.text.trim() == '') {
                                    _isPhoneError = true;
                                  }
                                  if (_pwdController.text.trim() == '') {
                                    _isPwdError = true;
                                  }
                                  if (_confPwdController.text.trim() == '') {
                                    _isConfPwdError = true;
                                  }
                                });

                                await dialogBoxAppDialog(
                                  context: context,
                                  title: "",
                                  msg: 'Por favor, corrija os campos marcados',
                                );
                                return;
                              }
                            } else {
                              setState(() {
                                if (_confPwdController.text.trim() == '') {
                                  _isConfPwdError = true;
                                }
                              });

                              await dialogBoxAppDialog(
                                context: context,
                                title: "",
                                msg: 'Por favor, corrija os campos marcados',
                              );
                            }
                          } else {
                            await dialogBoxAppDialog(
                              context: context,
                              title: 'Atenção',
                              msg:
                                  'Aceite os termos e condições e a política de privacidade para continuar.',
                            );
                            return;
                          }
                        },
                      ),
                      sh(50),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
