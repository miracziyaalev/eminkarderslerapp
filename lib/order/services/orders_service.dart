import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../model/orders_model.dart';

class GetWorkOrdersService {
  // ignore: body_might_complete_normally_nullable
  static Future<List<GetWorkOrdersInfModel>?> fetchWorkOrdersInfo() async {
    try {
      var response = await http.get(
        Uri.parse(Constants.baseURL + Constants.getWorkOrdersUrl),
        headers: {"content-type": "application/json"},
      );

      if (response.statusCode == 200) {
        var workOrders = (json.decode(response.body) as List)
            .map((i) => GetWorkOrdersInfModel.fromJson(i))
            .toList();
        return workOrders;
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
