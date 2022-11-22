import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../model/order_materials_model.dart';

class GetMaterialsOrders {
  // ignore: body_might_complete_normally_nullable
  static Future<List<GetOrdersMaterials>?> fetchMaterialsData(
      String mmpsNo, int siraNo) async {
    try {
      var response = await http.get(
        Uri.parse(Constants.baseURL +
            Constants.getMaterialsUrl +
            mmpsNo +
            '&R_SiraNo=' +
            siraNo.toString()),
        headers: {"content-type": "application/json"},
      );

      if (response.statusCode == 200) {
        var materialsData = (json.decode(response.body) as List)
            .map((i) => GetOrdersMaterials.fromJson(i))
            .toList();

        return materialsData;
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
