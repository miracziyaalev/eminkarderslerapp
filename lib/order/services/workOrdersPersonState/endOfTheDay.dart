import 'package:eminkardeslerapp/core/constants.dart';
import 'package:http/http.dart' as http;

class EndOfTheDay {
  static Future<dynamic> endOfTheDay() async {
    try {
      var response = await http.post(
        Uri.parse('${Constants.baseURL}${Constants.endOfTheDay}'),
        headers: {
          'Authorization': 'Bearer ${Constants.bearerToken}',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
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
