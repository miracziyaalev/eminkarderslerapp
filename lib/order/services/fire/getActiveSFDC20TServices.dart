import 'dart:convert';
import 'dart:developer';

import 'package:eminkardeslerapp/core/constants.dart';
import 'package:http/http.dart' as http;

import '../../model/fire/SFDC20T_model.dart';

class Sfdc20TActive {
  // ignore: body_might_complete_normally_nullable
  static Future<Sfdc20tModel?> fetchSfdc20TActive() async {
    try {
      var response = await http.get(
        Uri.parse(Constants.baseURL + Constants.getAciteveSfdc20T),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer ${Constants.bearerToken}',
        },
      );

      if (response.statusCode == 200) {
        return Sfdc20tModel.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load info trnum');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
