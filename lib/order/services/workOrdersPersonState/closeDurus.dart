import 'package:eminkardeslerapp/core/constants.dart';
import 'package:http/http.dart' as http;

class CloseDurus {
  static Future<dynamic> closeDurusService() async {
    try {
      var response = await http.post(
        Uri.parse('${Constants.baseURL}${Constants.closeDurus}'),
        headers: {
          'Authorization': 'Bearer ${Constants.bearerToken}',
          'Content-Type': 'application/json'
        },
      );

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
