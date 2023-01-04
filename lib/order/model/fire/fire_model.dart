// To parse this JSON data, do
//
//     final sfdc20SModel = sfdc20SModelFromJson(jsonString);

import 'dart:convert';

Sfdc20SModel sfdc20SModelFromJson(String str) =>
    Sfdc20SModel.fromJson(json.decode(str));

String sfdc20SModelToJson(Sfdc20SModel data) => json.encode(data.toJson());

class Sfdc20SModel {
  Sfdc20SModel({
    required this.evrakNo,
    required this.orTrnum,
    required this.sebep,
    required this.sfMiktar,
    required this.kod,
  });

  String evrakNo;
  String orTrnum;
  String sebep;
  int sfMiktar;
  String kod;

  factory Sfdc20SModel.fromJson(Map<String, dynamic> json) => Sfdc20SModel(
        evrakNo: json["evrakNo"] ?? "",
        orTrnum: json["or_Trnum"] ?? "",
        sebep: json["sebep"] ?? "",
        sfMiktar: json["sf_Miktar"] ?? 0,
        kod: json["kod"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "evrakNo": evrakNo,
        "or_Trnum": orTrnum,
        "sebep": sebep,
        "sf_Miktar": sfMiktar,
        "kod": kod,
      };
}
