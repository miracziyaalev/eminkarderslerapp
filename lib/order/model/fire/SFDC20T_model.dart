// To parse this JSON data, do
//
//     final operationModel = operationModelFromJson(jsonString);

import 'dart:convert';

List<Sfdc20tModel> operationModelFromJson(String str) =>
    List<Sfdc20tModel>.from(
        json.decode(str).map((x) => Sfdc20tModel.fromJson(x)));

String operationModelToJson(List<Sfdc20tModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sfdc20tModel {
  Sfdc20tModel({
    required this.id,
    required this.evrakType,
    required this.evrakNo,
    required this.trnum,
    required this.srnum,
    required this.tarih,
    required this.kod,
    required this.sure,
    required this.mpsNo,
    required this.recTarih1,
    required this.recTime1,
    required this.recTime2,
    required this.recTarih2,
    required this.operasyon,
    required this.operasyonAD,
    required this.d7IslemKodu,
    required this.d7Aksiyon,
    required this.vardiya,
    required this.durmaSebebi,
    required this.tmMiktar,
    required this.logUsername,
    required this.mamulKod,
    required this.receteKod,
    required this.mpstmTrnum,
    required this.toplamOprtrSSt,
    required this.sfdc20SOtTrnum,
    required this.operasynTekrarSays,
    required this.jobNo,
    required this.operator1,
    required this.tlogApp,
    required this.tlogBapp,
    required this.fire,
    required this.refnum1,
    required this.toplamDurus,
    required this.startDate,
    required this.acikKapali,
  });

  int id;
  String evrakType;
  String evrakNo;
  String trnum;
  String srnum;
  String tarih;
  String kod;
  double sure;
  String mpsNo;
  String recTarih1;
  String recTime1;
  String recTime2;
  String recTarih2;
  dynamic operasyon;
  String operasyonAD;
  String d7IslemKodu;
  String d7Aksiyon;
  String vardiya;
  dynamic durmaSebebi;
  double tmMiktar;
  dynamic logUsername;
  String mamulKod;
  String receteKod;
  String mpstmTrnum;
  double toplamOprtrSSt;
  String sfdc20SOtTrnum;
  double operasynTekrarSays;
  String jobNo;
  String operator1;
  String tlogApp;
  String tlogBapp;
  double fire;
  double refnum1;
  double toplamDurus;
  String startDate;
  bool acikKapali;

  factory Sfdc20tModel.fromJson(Map<String, dynamic> json) => Sfdc20tModel(
        id: json["id"] ?? 0,
        evrakType: json["evrakType"] ?? "",
        evrakNo: json["evrakNo"] ?? "",
        trnum: json["trnum"] ?? 0,
        srnum: json["srnum"] ?? 0,
        tarih: json["tarih"] ?? "",
        kod: json["kod"] ?? "",
        sure: json["sure"] * 60 ?? 0.0,
        mpsNo: json["mpsNo"] ?? "",
        recTarih1: json["recTarih1"] ?? "",
        recTime1: json["recTime1"] ?? "",
        recTime2: json["recTime2"] ?? "",
        recTarih2: json["recTarih2"] ?? "",
        operasyonAD: json["operasyonAD"] ?? "",
        operasyon: json["operasyon"],
        d7IslemKodu: json["d7_Islem_Kodu"] ?? "",
        d7Aksiyon: json["d7_Aksiyon"] ?? "",
        vardiya: json["vardiya"] ?? "",
        durmaSebebi: json["durmaSebebi"],
        tmMiktar: json["tm_Miktar"] ?? 0.0,
        logUsername: json["log_Username"],
        mamulKod: json["mamulKod"] ?? "",
        receteKod: json["receteKod"] ?? "",
        mpstmTrnum: json["mpstm_Trnum"] ?? "",
        toplamOprtrSSt: json["toplam_Oprtr_S_ST"] * 60 ?? 0.0,
        sfdc20SOtTrnum: json["sfdc20s_Ot_Trnum"] ?? "",
        operasynTekrarSays: json["operasyn_Tekrar_Sayısı"] ?? 0.0,
        jobNo: json["jobNo"] ?? "",
        operator1: json["operator_1"] ?? "",
        tlogApp: json["tlog_App"] ?? "",
        tlogBapp: json["tlog_Bapp"] ?? "",
        fire: json["fire"] ?? 0.0,
        refnum1: json["refnum1"] ?? 0.0,
        toplamDurus: json["toplam_Durus"] * 60 ?? 0.0,
        startDate: json["startDate"] ?? "",
        acikKapali: json["acik_Kapali"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "evrakType": evrakType,
        "evrakNo": evrakNo,
        "trnum": trnum,
        "srnum": srnum,
        "tarih": tarih,
        "kod": kod,
        "sure": sure,
        "mpsNo": mpsNo,
        "recTarih1": recTarih1,
        "recTime1": recTime1,
        "recTime2": recTime2,
        "recTarih2": recTarih2,
        "operasyon": operasyon,
        "operasyonAD": operasyonAD,
        "d7_Islem_Kodu": d7IslemKodu,
        "d7_Aksiyon": d7Aksiyon,
        "vardiya": vardiya,
        "durmaSebebi": durmaSebebi,
        "tm_Miktar": tmMiktar,
        "log_Username": logUsername,
        "mamulKod": mamulKod,
        "receteKod": receteKod,
        "mpstm_Trnum": mpstmTrnum,
        "toplam_Oprtr_S_ST": toplamOprtrSSt,
        "sfdc20s_Ot_Trnum": sfdc20SOtTrnum,
        "operasyn_Tekrar_Sayısı": operasynTekrarSays,
        "jobNo": jobNo,
        "operator_1": operator1,
        "tlog_App": tlogApp,
        "tlog_Bapp": tlogBapp,
        "fire": fire,
        "refnum1": refnum1,
        "toplam_Durus": toplamDurus,
        "startDate": startDate,
        "acik_Kapali": acikKapali,
      };
}
