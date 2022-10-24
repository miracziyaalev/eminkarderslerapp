import 'dart:convert';

import 'package:eminkardeslerapp/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  static Future<bool?> fetchUserLogin(String email, String password) async {
    try {
      var response = await http.post(
          Uri.parse(Constants.baseURL + Constants.loginEndURL),
          headers: {"content-type": "application/json"},
          body: jsonEncode({'userName': email, 'password': password}));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        Constants.bearerToken = json["token"];
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString("userName", email);
        await prefs.setString("password", password);
        return true;
      } else {
        return false;
      }
    } on Exception {
      return null;
    }
  }
}
