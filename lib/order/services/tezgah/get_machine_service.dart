import 'dart:convert';
import 'dart:developer';

import 'package:eminkardeslerapp/order/model/machine_model.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';

class GetMachineStateService {
  // ignore: body_might_complete_normally_nullable
  static Future<List<GetMachineStateModel>?> fetchMachineStatesInfo() async {
    try {
      var response = await http.get(
        Uri.parse(Constants.baseURL + Constants.GetAllTezgahStatus),
        headers: {"content-type": "application/json"},
      );
      print(response.body);
      if (response.statusCode == 200) {
        var machineStates = (json.decode(response.body) as List)
            .map((i) => GetMachineStateModel.fromJson(i))
            .toList();
        return machineStates;
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
