import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../utils/custom_shared_preferences.dart';
import '../login/login.dart';
import '../../models/chat.dart';
import '../../models/custom_error.dart';
import '../../repositories/chat_repository.dart';
import '../../screens/add_chat/add_chat.dart';
import '../../utils/state_control.dart';

class HomeController extends StateControl {
  final BuildContext context;

  HomeController({required this.context}) {
    init();
  }

  final ChatRepository _chatRepository = ChatRepository();

  bool _error = false;
  bool get error => _error;

  bool _loading = true;
  bool get loading => _loading;

  final List<User> _users = [];
  List<User> get users => _users;

  List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  @override
  void init() {
    getChats();
  }

  void getChats() async {
    final dynamic chatResponse = await _chatRepository.getChats();
    if (chatResponse is CustomError) {
      print('Error: $chatResponse');
      _error = true;
    }

    if (chatResponse is List<Chat>) {
      _chats = await Future.wait(chatResponse.map((chat) => chat.formatChat()));
      print('Chats: $chats');
    }

    _loading = false;
    notifyListeners();
  }

  Future<User> getUserFromSharedPreferences() async {
    final savedUser = await CustomSharedPreferences.get('user');
    User user = User.fromJson(jsonDecode(savedUser));
    return user;
  }

  void logout() async {
    await CustomSharedPreferences.remove('user');
    await CustomSharedPreferences.remove('token');
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
  }

  void openAddChatScreen() {
    Navigator.of(context).pushNamed(AddChatScreen.routeName);
  }

}
