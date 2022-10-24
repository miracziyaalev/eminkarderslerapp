import 'package:eminkardeslerapp/login/model/get_user_model.dart';

class Constants {
  static String baseURL = "http://emkaapi.somee.com/api/";
  static String loginEndURL = "Account/Login";
  static String getUserInfoUrl = "Account/GetUserInfo";
  static String getWorkOrdersUrl = "Mmps10e/getIsEmri";
  static String getInsideOrdersUrl = "Mmps10e/getOrders/";

  static String bearerToken = "";
  static String userName = "";
  static String password = "";
  static bool? isLoggedIn;
  static GetUserInfoModel? testUser;
  static var deneme;
}
