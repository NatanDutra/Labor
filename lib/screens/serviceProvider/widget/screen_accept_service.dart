import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../model/Usuario.dart';
import 'package:labor/utils/statusRequest.dart';
import 'package:labor/utils/user_firebase.dart';

import '../../../utils/colors.dart';


class ScreenAcceptService extends StatefulWidget {
  String? idRequisicao;
  ScreenAcceptService({super.key, required this.idRequisicao});

  @override
  State<ScreenAcceptService> createState() => _ScreenAcceptServiceState();
}

class _ScreenAcceptServiceState extends State<ScreenAcceptService> {
  String _textButton = "Aceitar serviço";
  Color _corButton = blueColor2;
  late Function _functionButton;
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = CameraPosition(target: LatLng(-21.139067, -47.8193591),);
  late Map<String, dynamic> _dadosRequisicao;

    _alterButtonMain(String texto, Color cor, Function funcao){
    setState(() {
      _textButton = texto;
      _corButton = cor;
      _functionButton = funcao;
    });
  }

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

    _listenerLocation(){
    var geolocator = Geolocator();
    var locationOptions = const LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10
    );

    geolocator.getPositionStream(locationOptions).listen((Position position) {

    _posicaoCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 19
      );

    _moveCamera( _posicaoCamera );  

    });
  }
      _lastLocation() async {
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
        _posicaoCamera = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 19
      );

      _moveCamera(_posicaoCamera);
    });
  }


    _moveCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        cameraPosition
      ),
    );
  }

  _recoverRequest() async {
    String? idRequest = widget.idRequisicao;

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot documentSnapshot = await db.collection("requisicoes").doc(idRequest).get();

    _dadosRequisicao = documentSnapshot.data as Map<String, dynamic>;
    _addListenerRequest();
  }

  _addListenerRequest() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String idRequest = _dadosRequisicao['id'];
    await db.collection("requisicoes").doc(idRequest).snapshots().listen((snapshot) {
      Map<String, dynamic> dados = snapshot.data as Map<String, dynamic>;
      String status = dados['status'];

      switch(status){
          case StatusRequest.AGUARDANDO:
            _statusAguardando();
            break;
          case StatusRequest.A_CAMINHO:
          break;
          case StatusRequest.EM_ANDAMENTO:
          _statusAndamento();
          break;
          case StatusRequest.FINALIZADO:

          break;
        }
    });
  }

  _statusAguardando(){
    _alterButtonMain(
      "Cancelar", blueColor2, (){
        _acceptWork();
      });
  }

    _statusAndamento(){
    _alterButtonMain(
      "O trabalho está em andamento", grayColor, (){
        _functionNull();
      });
  }

  _functionNull() {
    return null;
  }

  _acceptWork() async {

    Usuario serviceProvider = await UserFirebase.getDataUserLogged();

    FirebaseFirestore db = FirebaseFirestore.instance;
    String idRequest = _dadosRequisicao as String;

    db.collection('requisicoes').doc(idRequest).update({
      "provider" : serviceProvider.toMap(),
      "status" : StatusRequest.EM_ANDAMENTO
    }).then((_){
      String idContractor = _dadosRequisicao['contractor']['idUsuario'];
      db.collection('requisicao_ativa').doc(idContractor).update({
        "status" : StatusRequest.EM_ANDAMENTO
      });
    });

    String idServiceProvider = serviceProvider.idUsuario;
      db.collection('requisicao_ativa_service_provider').doc(idServiceProvider).set({
        "id_requisicao" : idRequest,
        "id_usuario" : idServiceProvider,
        "status" : StatusRequest.EM_ANDAMENTO
      });
  }
  

  @override
  void initState() {
    super.initState();
    _listenerLocation();
    _lastLocation();
    _recoverRequest();
    _dadosRequisicao;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Painel de Serviço"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _posicaoCamera,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              //-23,559200, -46,658878
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