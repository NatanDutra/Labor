import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/Usuario.dart';

class UserFirebase {
  static Future<User> getUserCurrent() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser!;
  }

  static Future<Usuario> getDataUserLogged() async {
    User user = await getUserCurrent();
    String idUsuario = user.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await db.collection('usuarios').doc(idUsuario).get();

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String tipoUsuario = data["tipoUsuario"];
    String email = data["email"];
    String nome = data["nome"];

    Usuario usuario = Usuario();
    usuario.idUsuario = idUsuario;
    usuario.tipoUsuario = tipoUsuario;
    usuario.email = email;
    usuario.nome = nome;

    return usuario;
  }
}