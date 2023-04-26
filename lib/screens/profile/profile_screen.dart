import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/app_text_field.dart';
import '../../utils/size_config.dart';
import '../../utils/colors.dart';
import '../../utils/size_config.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TextEditingController phoneController = TextEditingController()
    ..text = '(16) 99700-4404';
  TextEditingController addressController = TextEditingController()
    ..text = 'Rua Pinheiro dos Alves, 128';
  TextEditingController birthdateController = TextEditingController()
    ..text = '14/01/1999';

  bool edit = false;
  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _globalKey,
        drawer: Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Column(children: const [
            Padding(padding: EdgeInsets.only(top: 20, left: 110)),
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/mariana.png'),
            ),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Mariana Borges',
                style: TextStyle(
                    fontSize: 16,
                    color: grayColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Epilogue'),
              ),
              Text(
                'mariana_borges@gmail.com',
                style: TextStyle(
                    fontSize: 14,
                    color: grayColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Epilogue'),
              ),
            ],
          )
        ],
      ),
    ),
         Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        ListTile(
          leading: const Icon(
            Icons.account_circle_outlined,
            color: primaryColor,
          ),
          title: const Text(
            'Meu Perfil',
            style: TextStyle(
                color: grayColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'Epilogue'),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Profile(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.settings,
            color: primaryColor,
          ),
          title: const Text(
            'Configurações',
            style: TextStyle(
                color: grayColor, fontWeight: FontWeight.w400, fontSize: 15),
          ),
          onTap: () {},
        ),
        const Divider(
          color: blackColor,
        ),
        ListTile(
          leading: const Icon(
            Icons.cancel_outlined,
            color: primaryColor,
          ),
          title: const Text(
            'Sair',
            style: TextStyle(
                color: grayColor, fontWeight: FontWeight.w400, fontSize: 15),
          ),
          onTap: () async {
            dialogBoxLogoutApp(
              context: context,
            );
            _deslogarUsuario();
          },
        ),
      ],
    ),
        ],
      ),
    ),
  ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: scaleHeight * 3)),
                Row(
                  children: [
                    BackButton(
                      color: primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 85),
                      width: 70,
                      height: 39,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Onco',
                            style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 5, top: 5)),
                    const Text(
                      'genética',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
                const Divider(
                  color: blackColor,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: scaleWidth * 22, vertical: scaleHeight * 70),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: scaleHeight * 10),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: transparent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: shadowColor2,
                          offset: Offset(2, 5),
                        )
                      ],
                    ),
                    child: Column(
                      children: const [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/mariana.png'),
                          radius: 60,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: scaleWidth * 10),
                    child: Column(children: [
                      const Text('Mariana Borges dos Santos',
                          style: TextStyle(
                              color: blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: scaleHeight * 3)),
                      const Text('marina.borges@gmail.com',
                          style: TextStyle(
                              color: blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: scaleHeight * 25),
                    width: scaleWidth * 310,
                    height: scaleHeight * 320,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor2,
                          blurRadius: 10,
                          offset: Offset(1, 3),
                        )
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: scaleWidth * 20,
                        vertical: scaleHeight * 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Informações Pessoais',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Visibility(
                                visible: !edit,
                                child: SizedBox(
                                  width: 90,
                                  height: 30,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        edit = !edit;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: secondaryColor),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    child: const Text(
                                      'Editar',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: secondaryColor),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: scaleHeight * 12)),
                        Row(
                          children: [
                            buildPhone(),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            buildAddress(),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            buildBirthday(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Visibility(
                                visible: edit,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 130,
                                      height: 30,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            edit = !edit;
                                          });
                                        },
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: secondaryColor),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        child: const Text(
                                          'Salvar',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: secondaryColor),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: scaleWidth * 15)),
                                    SizedBox(
                                      width: 130,
                                      height: 30,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            edit = !edit;
                                          });
                                        },
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: primaryColor),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        child: const Text(
                                          'Cancelar',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPhone() => AppTextFieldIcon(
        controller: phoneController,
        input: 'phone',
        enabled: edit,
        width: scaleWidth * 270,
        inputType: TextInputType.phone,
        icon: Icons.phone,
      );

  Widget buildAddress() => AppTextFieldIcon(
        controller: addressController,
        input: 'address',
        enabled: edit,
        width: scaleWidth * 270,
        inputType: TextInputType.emailAddress,
        icon: Icons.location_on,
      );

  Widget buildBirthday() => AppTextFieldIcon(
        controller: birthdateController,
        input: 'birthday',
        enabled: false,
        width: scaleWidth * 270,
        inputType: TextInputType.datetime,
        icon: Icons.calendar_month,
      );
}
