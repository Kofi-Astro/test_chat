import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test_chat/utils/socket_controller.dart';

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
  IO.Socket socket = SocketController.socket;

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
    initSocket();
  }

  void initSocket() {
    emitUserIn();
    onMessage();
  }

  void emitUserIn() async {
    User user = await getUserFromSharedPreferences();
    Map<String, dynamic> json = user.toJson();
    socket.emit('user-in', json);
  }

  void onMessage() async {
    socket.on('message', (dynamic data) async {
      // Map<String, dynamic> json = data;

      print('data: $data');

      Map<String, dynamic> json = jsonDecode(data);
      Chat chat = Chat.fromJson(json);

      int chatIndex = _chats.indexWhere((_chat) => _chat.id == chat.id);

      if (chatIndex > -1) {
        _chats[chatIndex].messages = chat.messages;
      } else {
        _chats.add(await chat.formatChat());
      }
      notifyListeners();
    });
  }

  void emitUserLeft() async {
    socket.emit("user-left");
  }

  void getChats() async {
    final dynamic chatResponse = await _chatRepository.getChats();
    if (chatResponse is CustomError) {
      print('Error: $chatResponse');
      _error = true;
    }

    if (chatResponse is List<Chat>) {
      // _chats = await Future.wait(chatResponse.map((chat) => chat.formatChat()));
      // print('Chats: $chats');

      _chats = await formatChats(chatResponse);
    }

    _loading = false;
    notifyListeners();
  }

  Future<List<Chat>> formatChats(List<Chat> chats) async {
    return await Future.wait(chats.map((chat) => chat.formatChat()));
  }

  Future<User> getUserFromSharedPreferences() async {
    final savedUser = await CustomSharedPreferences.get('user');
    User user = User.fromJson(jsonDecode(savedUser));
    return user;
  }

  void logout() async {
    emitUserLeft();
    await CustomSharedPreferences.remove('user');
    await CustomSharedPreferences.remove('token');
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
  }

  void openAddChatScreen() {
    Navigator.of(context).pushNamed(AddChatScreen.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    emitUserLeft();
  }
}
