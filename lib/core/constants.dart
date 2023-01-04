import 'package:eminkardeslerapp/login/model/get_user_model.dart';
import 'package:flutter/cupertino.dart';

class Constants {
  static String baseURL = "http://emkaapi.somee.com/api/";

  static String loginEndURL = "Account/Login";
  static String getUserInfoUrl = "Account/GetUserInfo";
  static String getWorkOrdersUrl = "Mmps10e/getIsEmri";
  static String getInsideOrdersUrl = "Mmps10e/getOrders/";
  static String getMaterialsUrl = "Operation/getOperationDetail?EvrakNo=";
  static String getCycleUrl = "Operation/getCevrimSuresi?BomrecCode=";
  static String GetAllTezgahStatus = "Tezgah/GetAllTezgahStatus";
  static String getWorktoPerson = "Personel_IE/AddPersonelIE";
  static String endOfTheDay = "Personel_IE/GunSonuPersonel_IE";
  static String endOfTheWorkOrder = "Personel_IE/ClosePersonel_IE";
  static String addDurus = "Personel_IE/AddDurus";
  static String closeDurus = "Personel_IE/CloseDurus";
  static String addFire = "Quality/AddSfdc20S";
  static String getAciteveSfdc20T = "Quality/getActiveSfdc20T";
  static String getAlternatifTezgah =
      "Operation/alernatifTezgahList?BomrecCode=";

  static String bearerToken = "";
  static String userName = "";
  static String password = "";
  static bool? isLoggedIn;
  static bool? isHasIE;
  static GetUserInfoModel? testUser;
  static var deneme;
  static bool checkState = false;

  static BorderRadius cardBorderRadius = BorderRadius.circular(20);

  static const String pictures = "assets/mamulAssets/";

  static String workOrderIE = "";
  static String workOrderName = "";
  static String workOrderCompany = "";

  static String personelCode = "";
  static String personelName = "";
}

class CustomSize {
  static double width = 0.0;
  static double height = 0.0;
  static int counter = 1;
}

class RequiredParameter {
  static String requiredEvrakNo = "";
  static String requiredKod = "";
  static String requiredMpsNo = "";
  static String requiredD7IslemKodu = "";
  static String requiredMamulcode = "";
  static String requiredReceteCode = "";
  static String requiredJobNo = "";
  static String requiredOperator_1 = "";
  static int requiredCycleTime = 0;
  static String requiredCycleTimeCins = "";
  static String requiredMusteriAd = "";
  static String requiredMamulAd = "";
}
