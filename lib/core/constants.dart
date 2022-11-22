import 'package:eminkardeslerapp/login/model/get_user_model.dart';
import 'package:flutter/cupertino.dart';

class Constants {
  static String baseURL = "http://emkaapi.somee.com/api/";
  static String loginEndURL = "Account/Login";
  static String getUserInfoUrl = "Account/GetUserInfo";
  static String getWorkOrdersUrl = "Mmps10e/getIsEmri";
  static String getInsideOrdersUrl = "Mmps10e/getOrders/";
  static String getMaterialsUrl = "Operation/getOperationDetail?EvrakNo=";
  static String getCycleUrl = "getCevrimSuresi?BomrecCode=";

  static String bearerToken = "";
  static String userName = "";
  static String password = "";
  static bool? isLoggedIn;
  static GetUserInfoModel? testUser;
  static var deneme;

  static BorderRadius cardBorderRadius = BorderRadius.circular(20);
}
