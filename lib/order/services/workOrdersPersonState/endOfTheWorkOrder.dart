import 'package:eminkardeslerapp/core/constants.dart';
import 'package:http/http.dart' as http;

class EndOfTheWorkOrder {
  static Future<dynamic> endOfTheWorkOrder() async {
    try {
      var response = await http.post(
        Uri.parse('${Constants.baseURL}${Constants.endOfTheWorkOrder}'),
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
