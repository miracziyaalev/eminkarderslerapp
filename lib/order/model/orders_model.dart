// To parse this JSON data, do
//
//     final getWorkOrdersInfModel = getWorkOrdersInfModelFromJson(jsonString);

import 'dart:convert';

GetWorkOrdersInfModel getWorkOrdersInfModelFromJson(String str) =>
    GetWorkOrdersInfModel.fromJson(json.decode(str));

String getWorkOrdersInfModelToJson(GetWorkOrdersInfModel data) =>
    json.encode(data.toJson());

class GetWorkOrdersInfModel {
  GetWorkOrdersInfModel({
    required this.evrakno,
    required this.ad,
    required this.mamulstokkodu,
    required this.sFToplammiktar,
    required this.egbtariHOfo,
    required this.uretimdentestarih,
    required this.musteriAd,
  });

  String evrakno;
  String ad;
  String mamulstokkodu;
  int sFToplammiktar;
  String egbtariHOfo;
  String uretimdentestarih;
  String musteriAd;

  factory GetWorkOrdersInfModel.fromJson(Map<String, dynamic> json) =>
      GetWorkOrdersInfModel(
        evrakno: json["evrakno"] ?? '',
        ad: json["ad"] ?? '',
        mamulstokkodu: json["mamulstokkodu"] ?? '',
        sFToplammiktar: json["sF_TOPLAMMIKTAR"] ?? 0,
        egbtariHOfo: json["egbtariH_OFO"] ?? '',
        uretimdentestarih: json["uretimdentestarih"] ?? '',
        musteriAd: json["musteriAd"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "evrakno": evrakno,
        "ad": ad,
        "mamulstokkodu": mamulstokkodu,
        "sF_TOPLAMMIKTAR": sFToplammiktar,
        "egbtariH_OFO": egbtariHOfo,
        "uretimdentestarih": uretimdentestarih,
        "musteriAd": musteriAd,
      };
}
