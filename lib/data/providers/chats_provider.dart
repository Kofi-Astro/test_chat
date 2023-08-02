import 'package:flutter/material.dart';

import '../../models/chat.dart';
import '../../models/message.dart';

class ChatsProvider with ChangeNotifier {
  List<Chat> _chats = [];

  List<Chat> get chats => _chats;

  late Chat _selectedChat;

  Chat get selectedChat => _selectedChat;

  setChats(List<Chat> chats) {
    _chats = chats;
    notifyListeners();
  }

  setSelectedChat(Chat selectedChat) {
    _selectedChat = selectedChat;
    notifyListeners();
  }

  addMessageToSelectedChat(Message message) {
    _selectedChat.messages?.add(message);
  }
}
