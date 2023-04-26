
class Usuario {

  String? _idUsuario;
  String? _nome;
  String? _email;
  String? _password;
  String? _tipoUsuario;

  Usuario();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "nome" : nome,
      "email" : email,
      "tipoUsuario" : tipoUsuario,
    };

    return map;

  }

  String verificaTipoUsuario(bool tipoUsuario){
    return tipoUsuario ? "serviceProvider" : "contractor";
  }

  String get tipoUsuario => _tipoUsuario!;

  set tipoUsuario(String value) {
    _tipoUsuario = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  String get email => _email!;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome!;

  set nome(String value) {
    _nome = value;
  }

  String get idUsuario => _idUsuario!;

  set idUsuario(String value) {
    _idUsuario = value;
  }


}