import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../models/user.dart';
import '../login/login.dart';
import '../../utils/custom_shared_preferences.dart';
import '../../utils/socket_controller.dart';

class HomeController {
  final BuildContext context;

  HomeController({required this.context}) {
    init();
  }

  StreamController<String> streamController = StreamController();
  IO.Socket socket = SocketController.socket;

  List<User> _users = [];
  List<User> get users => _users;

  void init() {
    initSocket();
  }

  void initSocket() async {
    emitUserIn();
    socketOnUsersUpdate();
  }

  Future<User> getUserFromSharedPreferences() async {
    final savedUser = await CustomSharedPreferences.get('user');
    User user = User.frojmJson(jsonDecode(savedUser));
    return user;
  }

  void emitUserIn() async {
    User user = await getUserFromSharedPreferences();
    Map<String, dynamic> userJson = user.toJson();
    socket.emit('user-in', userJson);
  }

  void socketOnUsersUpdate() {
    socket.on('users-update', (dynamic data) async {
      List<dynamic> usersData = data;
      List<User> newUsers = data;
      User user = await getUserFromSharedPreferences();

      _users = newUsers.where((newUser) => newUser.id != user.id).toList();
      notifyListeners();
    });
  }

  removeUser(String id) {
    _users.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void logout() async {
    disconnectSocket();

    await CustomSharedPreferences.remove('user');
    await CustomSharedPreferences.remove('token');
    // Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false)
  }

  void notifyListeners() {
    streamController.add('change');
  }

  void connectSocket() {
    if (!socket.connected) {
      socket.connect();
    }
  }

  void disconnectSocket() {
    if (socket.connected) {
      socket.emit('user-left');

      socket.off('users-update');
    }
  }

  void dispose() {
    disconnectSocket();
    streamController.close();
  }
}
