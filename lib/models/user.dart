import 'dart:convert';


class User {
  String? id;
  String? email;
  String? username;
  String? token;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    username = json['username'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'username': username,
      'token': token,
    };
  }

  @override
  String toString() {
    Map<String, dynamic>? userJson;
    userJson!['_id'] = id;
    userJson['email'] = email;
    userJson['username'] = username;
    return json.encode(userJson);
  }
}
