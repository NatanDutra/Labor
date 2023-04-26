import 'package:cloud_firestore/cloud_firestore.dart';
import 'service.dart';
import 'Usuario.dart';

class Request {

  String? _id;
  String? _status;
  Usuario? _contractor;
  Usuario? _provider;
  ServiceProvider? _serviceProvider;

  Request(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    
    DocumentReference ref = db.collection("requisicoes").doc();
    id = ref.id;
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> dataContractor = {
    "nome" : contractor.nome,
    "email" : contractor.email,
    "tipoUsuario" : contractor.tipoUsuario,
    "idUsuario" : contractor.idUsuario,
    };

    Map<String, dynamic> dataService = {
      "service" : serviceProvider.service,
      "rua" : serviceProvider.rua,
      "numero" : serviceProvider.numero,
      "bairro" : serviceProvider.bairro,
      "cep" : serviceProvider.cep,
      "latitude" : serviceProvider.latitude,
      "longitude" : serviceProvider.longitude,
    };

    Map<String, dynamic> dataRequest = {
      "id" : id,
      "status" : status,
      "contractor" : dataContractor,
      "provider" : null,
      "serviceProvider" : dataService,
    };

    return dataRequest;

  }

  ServiceProvider get serviceProvider => _serviceProvider!;

  set serviceProvider(ServiceProvider value) {
    _serviceProvider = value;
  }

  Usuario get provider => _provider!;

  set provider(Usuario value) {
    _provider = value;
  }

  Usuario get contractor => _contractor!;

  set contractor(Usuario value) {
    _contractor = value;
  }

  String get status => _status!;

  set status(String value) {
    _status = value;
  } 

  
  String get id => _id!;
  set id(String value) {
    _id = value;
  }


}