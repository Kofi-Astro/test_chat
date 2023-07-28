import 'dart:convert';

class User {
  String? id;
  String? email;
  String? username;
  // String? token;

  User({
    required this.id,
    required this.email,
    required this.username,
    // this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    username = json['username'];
    // token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'username': username,
      // 'token': token,
    };
  }

  @override
  String toString() {
    // Map<String, dynamic>? userJson;
    // userJson!['_id'] = id;
    // userJson['email'] = email;
    // userJson['username'] = username;

    // print('This is the email: $email');
    // print('This is the email: $username');
    // print('This is the email: $id');
    // return json.encode(userJson);

    // print('This is the email: $email');
    // print('This is the email: $username');
    // print('This is the email: $id');

    // Map<String, dynamic> userJson = {
    //   '_id': id,
    //   'email': email,
    //   'username': username,
    // };
    // if (token != null) {
    //   userJson['token'] = token;
    // }

    // print(userJson);
    // return json.encode(userJson);

    return '{"_id":"$id", "email":"$email", "username":"$username"}';
  }
}
