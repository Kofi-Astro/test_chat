import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../models/message.dart';
import '../../models/user.dart';
import '../../utils/socket_controller.dart';

class ContactController {
  BuildContext context;
  User user;

  ContactController({required this.context, required this.user}) {
    init();
  }

  bool userOnlineInMyChat = false;

  StreamController streamController = StreamController();
  TextEditingController textEditingController = TextEditingController();

  IO.Socket socket = SocketController.socket;

  final List<Message> _messages = [];
  List<Message> get messages => _messages;

  void init() {
    initSocket();
  }

  void initSocket() async {
    socketOnMessage();
    socketOnEnteredChat();
    socketEnteredChat();
    socketOnLeaveChat();
  }

  socketEnteredChat() {
    socket.emit('entered-chat', user.socketId);
  }

  socketOnLeaveChat() {
    socket.emit('leave-chat', user.socketId);
  }

  void socketOnEnteredChat() {
    socket.on('entered-chat', (dynamic data) {
      String socketId = data;
      if (user.socketId == socketId) {
        if (!userOnlineInMyChat) {
          socketEnteredChat();
        }
        userOnlineInMyChat = true;
        notifyListeners();
      }
    });
  }

  void socketOnMessage() {
    socket.on('message', (dynamic data) {
      Message message = Message.fromJson(data);
      addMessage(message.text!, message.socketId!);
    });
  }

  void sendMessage() async {
    String text = textEditingController.value.text;
    socket.emit('message', {
      'to': user.socketId,
      'message': text,
    });
    textEditingController.text = '';
    addMessage(text, 'MY_SOCKET_ID');
  }

  void addMessage(String text, String socketId) {
    messages.add(Message(text: text, socketId: socketId));
    notifyListeners();
  }

  void notifyListeners() {
    streamController.add('change');
  }

  void closeSocketEvents() {
    if (socket.connected) {
      socket.off('entered-chat');
      socket.off('leave-chat');
      socket.off('message');
    }
  }

  dispose() {
    socketOnLeaveChat();
    closeSocketEvents();
    textEditingController.dispose();
    streamController.close();
  }
}
