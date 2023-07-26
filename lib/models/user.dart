import 'package:flutter/material.dart';

class User {
  String? id;
  String? email;
  String? username;
  String? socketId;
  String? currentChatSocketId;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.socketId,
    this.currentChatSocketId,
  });

  User.frojmJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    username = json['username'];
    socketId = json['socketId'];
    currentChatSocketId = json['currentChatSocketId'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'username': username,
      'socketId': socketId,
      'currentChatSocketId': currentChatSocketId,
    };
  }

  @override
  String toString() {
    return "{'_id': '$id', 'email': '$email', 'username': '$username', 'socketId': '$socketId', 'currentChatSocketId':'$currentChatSocketId'}";
  }
}
