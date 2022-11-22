// To parse this JSON data, do
//
//     final getOrdersMaterials = getOrdersMaterialsFromJson(jsonString);

import 'dart:convert';

GetOrdersMaterials getOrdersMaterialsFromJson(String str) =>
    GetOrdersMaterials.fromJson(json.decode(str));

String getOrdersMaterialsToJson(GetOrdersMaterials data) =>
    json.encode(data.toJson());

class GetOrdersMaterials {
  GetOrdersMaterials({
    required this.ad,
    required this.rKaynakkodu,
    required this.lotNumber,
    required this.rMiktar0,
    required this.d7RowVersion,
  });

  String ad;
  String rKaynakkodu;
  String lotNumber;
  int rMiktar0;
  String d7RowVersion;

  factory GetOrdersMaterials.fromJson(Map<String, dynamic> json) =>
      GetOrdersMaterials(
        ad: json["ad"] ?? "",
        rKaynakkodu: json["r_Kaynakkodu"] ?? "",
        lotNumber: json["lotNumber"] ?? "",
        rMiktar0: json["r_Miktar0"] ?? 0,
        d7RowVersion: json["d7RowVersion"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ad": ad,
        "r_Kaynakkodu": rKaynakkodu,
        "lotNumber": lotNumber,
        "r_Miktar0": rMiktar0,
        "d7RowVersion": d7RowVersion,
      };
}
