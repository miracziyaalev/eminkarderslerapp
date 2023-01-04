// To parse this JSON data, do
//
//     final cycleModel = cycleModelFromJson(jsonString);

import 'dart:convert';

CycleModel cycleModelFromJson(String str) =>
    CycleModel.fromJson(json.decode(str));

String cycleModelToJson(CycleModel data) => json.encode(data.toJson());

class CycleModel {
  CycleModel({
    required this.bomrecKaynak0Bv,
    required this.bomrecKaynak0Bu,
    required this.kalipKodu,
  });

  int bomrecKaynak0Bv;
  String kalipKodu;
  String bomrecKaynak0Bu;

  factory CycleModel.fromJson(Map<String, dynamic> json) => CycleModel(
        bomrecKaynak0Bv: json["bomrec_Kaynak0_Bv"] ?? 0,
        bomrecKaynak0Bu: json["bomrec_Kaynak0_Bu"] ?? "",
        kalipKodu: json["kalipKodu"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "bomrec_Kaynak0_Bv": bomrecKaynak0Bv,
        "bomrec_Kaynak0_Bu": bomrecKaynak0Bu,
        "kalipKodu": kalipKodu,
      };
}
