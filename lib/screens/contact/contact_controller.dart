import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../models/message.dart';
import '../../models/user.dart';
import '../../models/chat.dart';
import '../../models/custom_error.dart';

import '../../repositories/chat_repository.dart';
import '../../utils/custom_shared_preferences.dart';
import '../../utils/socket_controller.dart';
import '../../utils/state_control.dart';

class ContactController extends StateControl {
  BuildContext context;

  Chat chat;

  ContactController({
    required this.context,
    required this.chat,
  }) {
    init();
  }

  TextEditingController textEditingController = TextEditingController();

  IO.Socket socket = SocketController.socket;
  ChatRepository _chatRepository = ChatRepository();

  bool _error = false;
  bool get error => _error;

  bool _loading = true;
  bool get loading => _loading;

  void init() {
    socket.on('new-chat', (dynamic data) {
      print('This is the new-chat: $data');
    });

    socket.on('new-message', (dynamic data) {
      print('This is new-message: $data');
    });
  }

  void sendMessage() {
    String text = textEditingController.text;
    _chatRepository.sendMessage(chat.id!, text);
    addMessage(text);
    textEditingController.text = '';
    notifyListeners();
  }

  void addMessage(String text) {
    Message message = Message(
      text: text,
      userId: chat.myUser!.id,
    );
    chat.messages!.add(message);
  }

  void disconnectSocket() {
    if (socket.connected) {
      socket.disconnect();
    }
  }

  void dispose() {
    super.dispose();
    textEditingController.dispose();
    disconnectSocket();
  }
}
