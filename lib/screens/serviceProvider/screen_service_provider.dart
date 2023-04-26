import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labor/utils/statusRequest.dart';

import '../../utils/colors.dart';
import '../../widgets/app_dialog.dart';
import '../profile/profile_screen.dart';

class ServiceProviderScreen extends StatefulWidget {
  const ServiceProviderScreen({super.key});

  @override
  State<ServiceProviderScreen> createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {
  List<String> itensMenu = ["Configurações", "Sair"];
  final _controller = StreamController<QuerySnapshot>.broadcast();
  FirebaseFirestore db = FirebaseFirestore.instance;
  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }
  
  _choiceMenuItem(String choice){
    switch(choice){
      case "Sair" : _deslogarUsuario();
        break;
    }
  }
  Stream<QuerySnapshot> _addListenerRequest(){
    final stream = db.collection("requisicoes").where("status", isEqualTo: StatusRequest.AGUARDANDO).snapshots();

    stream.listen((data) {
      _controller.add(data);
    });
    return stream;
  }
  @override
  void initState() {
    super.initState();
    _addListenerRequest();
  }
  @override
  Widget build(BuildContext context) {

    var messageLoading = Center(child: Column(children: [
      Text("Carregando requisições"),
      CircularProgressIndicator()
    ]),);
    var messageRequestEmpty = Center(child: Column(children: [
      Text("Você não tem requisições", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      CircularProgressIndicator()
    ]),);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prestador de Serviço"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _choiceMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item){
                return PopupMenuItem<String>(value: item, child: Text(item));
              }).toList();
            },
          ),
        ],
      ),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return messageLoading;
            case ConnectionState.active:
            case ConnectionState.done:
            if(snapshot.hasError){
              return const Text("Erro ao carregar dados!");
            }else {
              QuerySnapshot<Object?>? querySnapshot = snapshot.data;
              if(querySnapshot!.docs.isEmpty){
                return messageRequestEmpty;
              }else {
                return ListView.separated(
                  itemBuilder: (context, indice){
                    List<DocumentSnapshot> requests = querySnapshot.docs.toList();
                    DocumentSnapshot item = requests[indice];
                    String idRequisicao = item['id'];
                    String nomeContractor = item['contractor']["nome"];
                    String rua = item['serviceProvider']["rua"];
                    String numero = item['serviceProvider']["numero"];

                    return ListTile(
                      title: Text(nomeContractor),
                      subtitle: Text("Endereço: $rua, $numero"),
                      onTap: (){
                        Navigator.pushNamed(context, '/job', arguments: idRequisicao);
                      },
                    );
                  },
                  separatorBuilder: (context, indice) => const Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                  itemCount: querySnapshot.docs.length,
                );
              }
            }
          }

      }),
    );
  }
}