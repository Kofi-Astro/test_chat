import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/custom_error.dart';
import '../../models/user_with_token.dart';
import '../../repositories/register_respository.dart';
import '../home/home.dart';
import '../../utils/custom_shared_preferences.dart';

class RegisterController {
  final BuildContext context;

  RegisterController({required this.context}) {
    init();
  }

  final RegisterRepository _registerRepository = RegisterRepository();
  StreamController<String> streamController = StreamController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _fomrSubmitting = false;
  get formSubmitting => _fomrSubmitting;

  void init() {
    usernameController.addListener(validateForm);
    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  void validateForm() {
    bool isFormValid = _isFormValid;
    String email = emailController.value.text;
    String username = usernameController.value.text;
    String password = passwordController.value.text;

    if (email.trim() == '' || username.trim() == '' || password.trim() == '') {
      isFormValid = false;
    } else {
      isFormValid = true;
    }
    _isFormValid = isFormValid;
    notifyListeners();
  }

  void submitForm() async {
    _fomrSubmitting = true;
    notifyListeners();
    String email = emailController.value.text;
    String username = usernameController.value.text;
    String password = passwordController.value.text;

    var loginResponse =
        await _registerRepository.register(email, username, password);

    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage!);
    } else if (loginResponse is UserWithToken) {
      await CustomSharedPreferences.setString('token', loginResponse.token!);
      await CustomSharedPreferences.setString(
          'user', loginResponse.user!.toString());
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (_) => false);
    }
    _fomrSubmitting = false;
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
        child: const Text('OK'));

    AlertDialog alert = AlertDialog(
      title: const Text('Verification error'),
      content: Text(message),
      actions: [okButton],
    );

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    streamController.close();
  }
}
