import 'dart:convert';

import 'package:eminkardeslerapp/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddPersonalIE {
  static Future<dynamic> addPersonnelIE(
      String workBench, String workOrder, int operationCode, int jobNo) async {
    try {
      var response = await http.post(
          Uri.parse('${Constants.baseURL}${Constants.getWorktoPerson}'),
          headers: {
            'Authorization': 'Bearer ${Constants.bearerToken}',
            'Content-Type': 'application/json'
          },
          body: json.encode({
            "workBench": workBench,
            "workOrder": workOrder,
            "operationCode": operationCode,
            "jobNo": jobNo
          }));

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isHasIE', true);

        return response.body;
      } else if (response.statusCode == 400) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isHasIE', false);
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
