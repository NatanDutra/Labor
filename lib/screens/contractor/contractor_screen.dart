import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:labor/model/request.dart';
import 'dart:async';
import 'dart:io';

import 'package:labor/utils/colors.dart';
import 'package:labor/utils/user_firebase.dart';

import '../../model/Usuario.dart';
import '../../model/service.dart';
import '../../utils/statusRequest.dart';
import '../../widgets/app_dialog.dart';
import '../profile/profile_screen.dart';

class ContractorScreen extends StatefulWidget {
  const ContractorScreen({super.key});

  @override
  State<ContractorScreen> createState() => _ContractorScreenState();
}

class _ContractorScreenState extends State<ContractorScreen> {

  final TextEditingController _controllerProvider = TextEditingController();
  final TextEditingController _dataController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  List<String> itensMenu = ["Configurações", "Sair"];
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = CameraPosition(target: LatLng(-21.139067, -47.8193591),);
  String? _idRequest;
  bool _showBoxAddress = true;
  String _textButton = "Procurar por prestador";
  Color _corButton = blueColor2;
  late Function _functionButton;

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamed(context, '/');
  }

  _choiceMenuItem(String choice){
    switch(choice){
      case "Sair" : _deslogarUsuario();
        break;
    }
  }
  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  _listenerLocation() async {
    var locationOptions = const LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10
    );

    Geolocator().getPositionStream(locationOptions).listen((Position position) {

    _posicaoCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 19,
    );
    _moveCamera(_posicaoCamera);
    });
  }

  _lastLocation() async {
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
        if(position != null){
            _posicaoCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 19
      );

        _moveCamera(_posicaoCamera);
      }
  }

  _moveCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        cameraPosition
      ),
    );
  }

  _saveRequest(ServiceProvider serviceProvider) async {
    Usuario contractor = await UserFirebase.getDataUserLogged();
    Request request = Request();
    request.serviceProvider = serviceProvider;
    request.contractor = contractor;
    request.status = StatusRequest.AGUARDANDO;

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("requisicoes").doc(request.id).set(request.toMap());

    Map<String, dynamic> dataRequestActive = {};
    dataRequestActive["id_requisicao"] = request.id;
    dataRequestActive["id_usuario"] = contractor.idUsuario;
    dataRequestActive["status"] = StatusRequest.AGUARDANDO;

    db.collection("requisicao_ativa").doc(contractor.idUsuario).set(dataRequestActive);
  }

  _findServiceProvider() async {
    String serviceProvider = _controllerProvider.text;
    String addressPosition = 'AV. COSTÁBILE ROMANO, 2,201';
    if(serviceProvider.isNotEmpty){
      List<Placemark> listPosition = await Geolocator().placemarkFromAddress(addressPosition);
      if(listPosition.isNotEmpty){
        Placemark address = listPosition[0];
        ServiceProvider serviceProvider = ServiceProvider();
        serviceProvider.service = _controllerProvider.text;
        serviceProvider.cidade = address.subAdministrativeArea;
        serviceProvider.cep = address.postalCode;
        serviceProvider.bairro = address.subLocality;
        serviceProvider.rua = address.thoroughfare;
        serviceProvider.numero = address.subThoroughfare;

        serviceProvider.latitude = address.position.latitude;
        serviceProvider.longitude = address.position.longitude;

        String confirmService;
        confirmService = "\n Serviço: ${serviceProvider.service}";
        confirmService += "\n Cidade: ${serviceProvider.cidade}";
        confirmService += "\n Rua: ${serviceProvider.rua}, ${serviceProvider.numero}";
        confirmService += "\n Bairro: ${serviceProvider.bairro}";

        showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Confirmação do serviço"),
          content: Text(confirmService, style: TextStyle(fontSize: 15),),
          contentPadding: const EdgeInsets.all(20),
          actions: <Widget>[
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Cancelar", style: TextStyle(color: Colors.red)),),
            TextButton(onPressed: (){
              _saveRequest(serviceProvider);
              Navigator.pop(context);
            }, child: const Text("Confirmar", style: TextStyle(color: Colors.green),))
          ],
        );
      });
      } 
    }
  }

  _alterButtonMain(String texto, Color cor, Function funcao){
    setState(() {
      _textButton = texto;
      _corButton = cor;
      _functionButton = funcao;
    });
  }

  _statusServiceNotCall(){
    _showBoxAddress = true;
    _alterButtonMain(
      "Procurar por prestador", blueColor2, (){
        _findServiceProvider();
      });
  }

  _statusAguardando(){
    _showBoxAddress = false;
    _alterButtonMain(
      "Cancelar", Colors.red, (){
        _cancelarUber();
      });
  }

  _cancelarUber() async {
    User firebaseUser = await UserFirebase.getUserCurrent();

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("requisicoes").doc(_idRequest).update({
      "status" : StatusRequest.CANCELADO
    }).then((_) {
      db.collection("requisicao_ativa").doc(firebaseUser.uid).delete();
    });
  }
  _addListenerRequestActive() async {
    User firebaseUser = await UserFirebase.getUserCurrent();

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("requisicao_ativa").doc(firebaseUser.uid).snapshots().listen((snapshot) {
        if(snapshot.data() != null){
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          String status = data["status"];
          _idRequest = data["id_requisicao"];

          switch(status){
          case StatusRequest.AGUARDANDO:
            _statusAguardando();
            break;
          case StatusRequest.A_CAMINHO:

          break;
          case StatusRequest.EM_ANDAMENTO:

          break;
          case StatusRequest.FINALIZADO:

          break;
        }
      }else{
        _statusServiceNotCall();
      }
    });
  }

  @override
  void initState()  {
    super.initState();
    _listenerLocation();
    _addListenerRequestActive();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contratante"),
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
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _posicaoCamera,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              //-23,559200, -46,658878
            ),
            Visibility(
              visible: _showBoxAddress,
              child: Stack(children: [
                Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                  padding: EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white
                  ),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 10,bottom: 10),
                        width: 10,
                        height: 10,
                        child: Icon(Icons.location_on, color: Colors.green,),
                      ),
                      hintText: "Meu local",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10)
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 55,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white
                  ),
                  child: TextField(
                    controller: _controllerProvider,
                    decoration: InputDecoration(
                        icon: Container(
                          margin: const EdgeInsets.only(left: 10, bottom: 10),
                          width: 10,
                          height: 10,
                          child: const Icon(Icons.work_history_outlined, color: Colors.black,),
                        ),
                        hintText: "Digite o tipo de serviço",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10)
                    ),
                  ),
                ),
              ),
            ),
              ],),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 100,
              child: Padding(
                padding: Platform.isIOS
                    ? const EdgeInsets.fromLTRB(20, 10, 20, 25)
                    : const EdgeInsets.all(10),
                child: ElevatedButton(
                    child: Text(
                      _textButton,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(_corButton)),     
                    onPressed: (){
                      _functionButton();
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}