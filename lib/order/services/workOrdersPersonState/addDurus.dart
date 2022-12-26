import 'package:eminkardeslerapp/core/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddDurus {
  static Future<dynamic> addDurusService(
      {required String d7islemKodu, required String durmaSebebi}) async {
    try {
      var response = await http.post(
          Uri.parse('${Constants.baseURL}${Constants.addDurus}'),
          headers: {
            'Authorization': 'Bearer ${Constants.bearerToken}',
            'Content-Type': 'application/json'
          },
          body: json
              .encode({"islemKodu": d7islemKodu, "durmaSebebi": durmaSebebi}));

      print(response.body);

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
