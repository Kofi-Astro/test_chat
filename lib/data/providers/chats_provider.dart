import 'package:flutter/material.dart';

import '../../models/chat.dart';
import '../../models/message.dart';

class ChatsProvider with ChangeNotifier {
  List<Chat> _chats = [];

  List<Chat> get chats => _chats;

  late Chat _selectedChat;

  Chat get selectedChat => _selectedChat;

  setChats(List<Chat> chats) {
    // _chats = chats;

    List<Chat> newChats = List<Chat>.from(chats);
    newChats.sort(
      (a, b) {
        if (a.messages!.isEmpty) return 1;
        if (b.messages!.isEmpty) return -1;

        int millisecondsA = a.messages![a.messages!.length - 1].createdAt!;
        int millisecondsB = b.messages![b.messages!.length - 2].createdAt!;

        return millisecondsA > millisecondsB ? -1 : 1;
      },
    );
    _chats = newChats;

    notifyListeners();
  }

  setSelectedChat(Chat selectedChat) {
    _selectedChat = selectedChat;
    notifyListeners();
  }

  addMessageToSelectedChat(Message message) {
    _selectedChat.messages?.add(message);
    setChats(_chats);
  }
}
