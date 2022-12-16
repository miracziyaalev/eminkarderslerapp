import 'dart:developer';

import 'package:eminkardeslerapp/login/model/get_user_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants.dart';

class UserInfoService {
  // ignore: body_might_complete_normally_nullable
  static Future<GetUserInfoModel?> fetchUserInfo() async {
    try {
      var token = Constants.bearerToken;
      var response = await http.get(
        Uri.parse(Constants.baseURL + Constants.getUserInfoUrl),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        
        return getUserInfoModelFromJson(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load info');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
