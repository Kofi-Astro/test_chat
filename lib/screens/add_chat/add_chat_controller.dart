
import 'package:flutter/material.dart';

import '../../models/custom_error.dart';
import '../../models/user.dart';

import '../../repositories/user_repository.dart';
import '../../utils/state_control.dart';

class AddChatController extends StateControl {
  final BuildContext context;
  AddChatController({required this.context}) {
    init();
  }

  final UserRepository _userRepository = UserRepository();

  bool _loading = true;
  bool get loading => _loading;

  bool _error = false;
  bool get error => _error;

  List<User> _users = [];
  List<User> get users => _users;

  @override
  void init() {
    getUsers();
  }

  void getUsers() async {
    dynamic response = await _userRepository.getUsers();
    if (response is CustomError) {
      _error = true;
    }
    if (response is List<User>) {
      _users = response;
    }

    _loading = false;
    notifyListeners();
  }

}
