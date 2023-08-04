import 'package:flutter/material.dart';
import 'package:test_chat/repositories/chat_repository.dart';

import '../../models/chat.dart';
import '../../models/message.dart';
import '../../data/providers/chats_provider.dart';

class ChatsProvider with ChangeNotifier {
  List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  ChatRepository _chatRepository = ChatRepository();

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

    if (_selectedChat != null) {
      _readSelectedChatMessages();
      _chatRepository.readChat(_selectedChat.id!);
      notifyListeners();
    }
  }

  _readSelectedChatMessages() {
    _selectedChat.messages = _selectedChat.messages?.map((message) {
      message.unreadByMe = false;
      return message;
    }).toList();
    updateSelectedChatInChats();
  }

  addMessageToSelectedChat(Message message) {
    _selectedChat.messages?.add(message);
    // setChats(_chats);
    updateSelectedChatInChats();
  }

  updateSelectedChatInChats() {
    List<Chat> newChats = _chats.map((chat) {
      if (chat.id == _selectedChat.id!) {
        chat = _selectedChat;
      }
      return chat;
    }).toList();
    setChats(newChats);
  }
}
