// utils
import 'package:labor/utils/regex.dart';

class Validation {
  bool hasError;
  bool hasError2;
  String hasMsg;

  Validation(
    this.hasError,
    this.hasError2,
    this.hasMsg,
  );
}

typeRegex(type) {
  switch (type) {
    case "name":
      return nameRegex.toString();

    case "email":
      return emailRegex.toString();

    case "cpf":
      return cpfRegex.toString();

    case "date":
      return dateRegex.toString();

    case "phone":
      return phoneRegex.toString();

    case "password":
      return passwordRegex.toString();
  }
}

Validation validation(val, type) {
  bool hasError;
  bool hasError2;
  String hasMsg;
  String validRegex;

  validRegex = typeRegex(type);

  RegExp regex = RegExp(validRegex);

  if (val!.isEmpty) {
    hasError = true;
    hasError2 = false;
    hasMsg = 'Empty value';

    return Validation(
      hasError,
      hasError2,
      hasMsg,
    );
  } else if ((!regex.hasMatch(val.trim()))) {
    hasError = true;
    hasError2 = true;
    hasMsg = 'Validation error';

    return Validation(
      hasError,
      hasError2,
      hasMsg,
    );
  } else {
    hasError = false;
    hasError2 = false;
    hasMsg = '';

    return Validation(
      hasError,
      hasError2,
      hasMsg,
    );
  }
}

Validation emptyValidation(val) {
  bool hasError;
  bool hasError2;
  String hasMsg;

  if (val!.isEmpty) {
    hasError = true;
    hasError2 = false;
    hasMsg = 'Error';

    return Validation(
      hasError,
      hasError2,
      hasMsg,
    );
  } else {
    hasError = false;
    hasError2 = false;
    hasMsg = '';

    return Validation(
      hasError,
      hasError2,
      hasMsg,
    );
  }
}
