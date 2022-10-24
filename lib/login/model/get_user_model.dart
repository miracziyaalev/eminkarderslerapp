// To parse this JSON data, do
//
//     final getUserInfoModel = getUserInfoModelFromJson(jsonString);

import 'dart:convert';

GetUserInfoModel getUserInfoModelFromJson(String str) =>
    GetUserInfoModel.fromJson(json.decode(str));

String getUserInfoModelToJson(GetUserInfoModel data) =>
    json.encode(data.toJson());

class GetUserInfoModel {
  GetUserInfoModel({
    required this.personelId,
    required this.code,
    required this.name,
    required this.adress,
    required this.gender,
    required this.avatarUrl,
    required this.createdTime,
    required this.department,
    required this.pozition,
    required this.lisans,
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  int personelId;
  String code;
  String name;
  String adress;
  String gender;
  String avatarUrl;
  DateTime? createdTime;
  String department;
  String pozition;
  String lisans;
  String username;
  String email;
  dynamic phoneNumber;

  factory GetUserInfoModel.fromJson(Map<String, dynamic> json) =>
      GetUserInfoModel(
        personelId: json["personelId"] ?? 0,
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        adress: json["adress"] ?? "",
        gender: json["gender"] ?? "",
        avatarUrl: json["avatarUrl"] ?? "",
        createdTime: json["createdTime"] == null
            ? null
            : DateTime.parse(json["createdTime"]),
        department: json["department"] ?? "",
        pozition: json["pozition"] ?? "",
        lisans: json["lisans"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "personelId": personelId,
        "code": code,
        "name": name,
        "adress": adress,
        "gender": gender,
        "avatarUrl": avatarUrl,
        "createdTime":
            createdTime == null ? null : createdTime!.toIso8601String(),
        "department": department,
        "pozition": pozition,
        "lisans": lisans,
        "username": username,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
