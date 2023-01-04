import 'dart:convert';

import 'package:eminkardeslerapp/core/constants.dart';
import 'package:http/http.dart' as http;

class AddFire {
  static Future<dynamic> addFireService({
    required String evrakNo,
    required String orTrnum,
    required String sebep,
    required int sfMiktar,
    required String kod,
  }) async {
    try {
      var response =
          await http.post(Uri.parse('${Constants.baseURL}${Constants.addFire}'),
              headers: {
                'Authorization': 'Bearer ${Constants.bearerToken}',
                'Content-Type': 'application/json'
              },
              body: json.encode({
                "evrakNo": evrakNo,
                "or_Trnum": orTrnum,
                "sebep": sebep,
                "sf_Miktar": sfMiktar,
                "kod": kod
              }));

      if (response.statusCode == 200) {
        Map<String, dynamic> result = {
          "status": response.statusCode,
          "message": response.body
        };
        return result;
      } else if (response.statusCode == 400) {
        Map<String, dynamic> result = {
          "status": response.statusCode,
          "message": response.body
        };
        return result;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
