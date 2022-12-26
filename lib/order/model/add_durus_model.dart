// To parse this JSON data, do
//
//     final addDurusModel = addDurusModelFromJson(jsonString);

import 'dart:convert';

AddDurusModel addDurusModelFromJson(String str) =>
    AddDurusModel.fromJson(json.decode(str));

String addDurusModelToJson(AddDurusModel data) => json.encode(data.toJson());

class AddDurusModel {
  AddDurusModel({
    required this.islemKodu,
    required this.durmaSebebi,
  });

  String islemKodu;
  String durmaSebebi;

  factory AddDurusModel.fromJson(Map<String, dynamic> json) => AddDurusModel(
      islemKodu: json["islemKodu"] ?? "",
      durmaSebebi: json["durmaSebebi"] ?? "");

  Map<String, dynamic> toJson() => {
        "islemKodu": islemKodu,
        "durmaSebebi": durmaSebebi,
      };
}
