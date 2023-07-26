import 'package:flutter/material.dart';

import './user.dart';

class UserWithToken {
  User? user;
  String? token;

  UserWithToken({
    this.user,
    this.token,
  });

  UserWithToken.fromJson(Map<String, dynamic> json) {
    user = User.frojmJson(json['user']);
    token = json['token'];
  }

  @override
  String toString() {
    return "{'user':${user.toString()}, 'token': '$token'}";
  }
}
