import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/user_with_token.dart';
import '../../models/custom_error.dart';
import '../../repositories/login_repository.dart';
import '../home/home.dart';
import '../../utils/custom_shared_preferences.dart';

class LoginController {
  final BuildContext context;

  LoginController({required this.context}) {
    init();
  }

  final LoginRepository _loginRepository = LoginRepository();
  StreamController<String> streamController = StreamController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _formSubmitting = false;
  get formSubmitting => _formSubmitting;

  void init() {
    usernameController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    streamController.close();
  }

  void submitForm() async {
    _formSubmitting = true;
    notifyListeners();

    String username = usernameController.value.text;
    String password = passwordController.value.text;

    var loginResponse = await _loginRepository.login(username, password);
    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage!);
    } else if (loginResponse is UserWithToken) {
      await CustomSharedPreferences.setString('token', loginResponse.token!);
      await CustomSharedPreferences.setString(
          'user', loginResponse.user.toString());
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
    _formSubmitting = false;
    notifyListeners();
  }

  void validateForm() {
    bool isFormValid = _isFormValid;
    String username = usernameController.value.text;
    String password = passwordController.value.text;

    if (username.trim() == '' || password.trim() == '') {
      isFormValid = false;
    } else {
      isFormValid = true;
    }

    _isFormValid = isFormValid;
    notifyListeners();
  }

  void notifyListeners() {
    streamController.add('change');
  }

  showAlertDialog(String message) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('OK'),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Verification error'),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
