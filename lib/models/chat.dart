import 'dart:convert';

import './message.dart';
import './user.dart';

import '../utils/custom_shared_preferences.dart';

class Chat {
  String? id;
  User? lowerIdUser;
  User? higherIdUser;
  List<Message>? messages;
  User? myUser;
  User? otherUser;

  Chat({
    required this.id,
    required this.lowerIdUser,
    required this.higherIdUser,
    required this.messages,
  });

  Chat.fromJson(Map<String, dynamic> json) {
    print("json = $json");
    id = json['_id'];
    lowerIdUser = User.fromJson(json['lowerId']);
    higherIdUser = User.fromJson(json['higherId']);
    List<dynamic> messages = json['messages'];
    messages = messages.map((message) => Message.fromJson(message)).toList();
  }

  Future<Chat> formatChat() async {
    adjustChatUsers();
    return this;
  }

  void adjustChatUsers() async {
    final String userString = await CustomSharedPreferences.get('user');
    final Map<String, dynamic> userJson = jsonDecode(userString);
    final myUserFromSharedPreferences = User.fromJson(userJson);

    if (myUserFromSharedPreferences.id == lowerIdUser!.id) {
      myUser = lowerIdUser;
      otherUser = higherIdUser;
    } else {
      otherUser = lowerIdUser;
      myUser = higherIdUser;
    }
  }
}