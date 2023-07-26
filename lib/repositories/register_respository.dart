import 'dart:convert';
import 'dart:math';

import '../models/custom_error.dart';
import '../models/user_with_token.dart';
import '../utils/custom_http_client.dart';
import '../utils/my_urls.dart';

class RegisterRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> register(
      String email, String username, String password) async {
    try {
      var body = jsonEncode(
          {'email': email, 'username': username, 'password': password});

      var response =
          await http.post(Uri.parse('${MyUrls.serverUrl}/user'), body: body);

      final dynamic loginResponse = jsonDecode(response.body);

      if (loginResponse['error'] != null) {
        return CustomError.fromJson(loginResponse);
      }

      final UserWithToken user = UserWithToken.fromJson(loginResponse);
      return user;
    } catch (error) {
      throw error;
    }
  }
}
