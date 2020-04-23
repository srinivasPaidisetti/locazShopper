import 'package:flutter/material.dart';
import 'package:locazshopper/viewmodels/base_model.dart';

class RegisterModel extends BaseModel {
  bool _validate = false;

  bool get validate => _validate;

  setValidate(bool validate) {
    _validate = validate;
    notifyListeners();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
}
