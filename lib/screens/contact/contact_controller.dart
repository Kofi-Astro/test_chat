import 'package:flutter/material.dart';
import '../../models/message.dart';
import '../../models/chat.dart';

import '../../repositories/chat_repository.dart';
import '../../utils/socket_controller.dart';
import '../../utils/state_control.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

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

  final bool _error = false;
  bool get error => _error;

  final bool _loading = true;
  bool get loading => _loading;

  @override
  void init() {
    socket.on('new-chat', (dynamic data) {
      print('New chat: $data');
    });

    socket.on('new-message', (dynamic data) {
      print('New message: $data');
    });
    notifyListeners();
  }

  void sendMessage() {
    String text = textEditingController.text;
    _chatRepository.sendMessage(chat.id!, text);
    // addMessage(text);
    textEditingController.text = '';
    // notifyListeners();

    Message message = Message(
      text: text,
      userId: chat.myUser!.id,
    );

    addMessage(message);
  }

  void addMessage(Message message) {
    chat.messages!.add(message);
    notifyListeners();
  }

  // void disconnectSocket() {
  //   if (socket.connected) {
  //     socket.disconnect();
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    // disconnectSocket();
  }
}
