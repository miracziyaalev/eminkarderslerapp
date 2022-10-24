import 'dart:convert';
import 'dart:developer';

import 'package:eminkardeslerapp/order/model/inside_orders_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants.dart';

class GetInsideOrdersService {
  // ignore: body_might_complete_normally_nullable
  static Future<List<GetInsideOrdersInfoModel>?> fetchInsideOrdersInfo(
      String mmpsNo) async {
    try {
      var response = await http.get(
        Uri.parse(Constants.baseURL + Constants.getInsideOrdersUrl + mmpsNo),
        headers: {"content-type": "application/json"},
      );

      if (response.statusCode == 200) {
        var insideOrders = (json.decode(response.body) as List)
            .map((i) => GetInsideOrdersInfoModel.fromJson(i))
            .toList();
        return insideOrders;
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
