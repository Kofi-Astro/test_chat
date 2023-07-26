import 'dart:convert';

import '../models/custom_error.dart';
import '../models/user_with_token.dart';
import '../utils/custom_http_client.dart';
import '../utils/my_urls.dart';

class LoginRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> login(String username, String password) async {
    try {
      var body = jsonEncode({'username': username, 'password': password});

      var response =
          await http.post(Uri.parse('${MyUrls.serverUrl}/auth'), body: body);
      final dynamic loginResponse = jsonDecode(response.body);

      if (loginResponse['error'] != null) {
        return CustomError.fromJson(loginResponse);
      }

      final UserWithToken user = UserWithToken.fromJson(loginResponse);
      return user;
    } catch (error) {
      return CustomError(error: true, errorMessage: 'Error has occured');
    }
  }
}
