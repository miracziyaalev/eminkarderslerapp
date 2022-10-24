// To parse this JSON data, do
//
//     final getInsideOrdersInfoModel = getInsideOrdersInfoModelFromJson(jsonString);

import 'dart:convert';

GetInsideOrdersInfoModel getInsideOrdersInfoModelFromJson(String str) =>
    GetInsideOrdersInfoModel.fromJson(json.decode(str));

String getInsideOrdersInfoModelToJson(GetInsideOrdersInfoModel data) =>
    json.encode(data.toJson());

class GetInsideOrdersInfoModel {
  GetInsideOrdersInfoModel({
    required this.rKaynakKodu,
    required this.evrakNo,
    required this.receteNotu,
    required this.rAcikKapali,
    required this.rYMamulMiktar,
    required this.rSiraNo,
    required this.operasyonAd,
  });

  String rKaynakKodu;
  String evrakNo;
  String receteNotu;
  String rAcikKapali;
  int rYMamulMiktar;
  int rSiraNo;
  String operasyonAd;

  factory GetInsideOrdersInfoModel.fromJson(Map<String, dynamic> json) =>
      GetInsideOrdersInfoModel(
        rKaynakKodu: json["r_KaynakKodu"] ?? "",
        evrakNo: json["evrakNo"] ?? "",
        receteNotu: json["receteNotu"] ?? "",
        rAcikKapali: json["r_Acik_Kapali"] ?? "",
        rYMamulMiktar: json["r_YMamulMiktar"] ?? 0,
        rSiraNo: json["r_SiraNo"] ?? 0,
        operasyonAd: json["operasyonAd"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "r_KaynakKodu": rKaynakKodu,
        "evrakNo": evrakNo,
        "receteNotu": receteNotu,
        "r_Acik_Kapali": rAcikKapali,
        "r_YMamulMiktar": rYMamulMiktar,
        "r_SiraNo": rSiraNo,
        "operasyonAd": operasyonAd,
      };
}
