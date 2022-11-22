import 'dart:convert';
import 'dart:developer';

import 'package:eminkardeslerapp/order/model/cycle_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants.dart';

class GetCycleTime {
  // ignore: body_might_complete_normally_nullable
  static Future<List<CycleModel>?> fetchCycleData(
      String stokcode, int siraNo) async {
    try {
      var response = await http.get(
        Uri.parse(Constants.baseURL +
            Constants.getCycleUrl +
            stokcode +
            '&R_SiraNo=' +
            siraNo.toString()),
        headers: {"content-type": "application/json"},
      );

      if (response.statusCode == 200) {
        var cycleData = (json.decode(response.body) as List)
            .map((i) => CycleModel.fromJson(i))
            .toList();

        return cycleData;
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
