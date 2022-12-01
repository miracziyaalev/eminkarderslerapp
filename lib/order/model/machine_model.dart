// To parse this JSON data, do
//
//     final getMachineStateModel = getMachineStateModelFromJson(jsonString);

import 'dart:convert';

GetMachineStateModel getMachineStateModelFromJson(String str) =>
    GetMachineStateModel.fromJson(json.decode(str));

String getMachineStateModelToJson(GetMachineStateModel data) =>
    json.encode(data.toJson());

class GetMachineStateModel {
  GetMachineStateModel({
    required this.workBenchCode,
    required this.workBenchName,
    required this.state,
    required this.personalCode,
    required this.personalName,
    required this.isEmri,
    required this.operation,
    required this.avatarUrl,
    required this.process,
  });

  String workBenchCode;
  String workBenchName;
  bool state;
  dynamic personalCode;
  dynamic personalName;
  dynamic isEmri;
  double operation;
  dynamic avatarUrl;
  String process;

  factory GetMachineStateModel.fromJson(Map<String, dynamic> json) =>
      GetMachineStateModel(
        workBenchCode: json["workBenchCode"] ?? "",
        workBenchName: json["workBenchName"] ?? "",
        state: json["state"] ?? false,
        personalCode: json["personalCode"],
        personalName: json["personalName"],
        isEmri: json["isEmri"],
        operation: json["operation"] ?? 0.0,
        avatarUrl: json["avatarUrl"],
        process: json["process"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "workBenchCode": workBenchCode,
        "workBenchName": workBenchName,
        "state": state,
        "personalCode": personalCode,
        "personalName": personalName,
        "isEmri": isEmri,
        "operation": operation,
        "avatarUrl": avatarUrl,
        "process": process,
      };
}
