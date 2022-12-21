import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eminkardeslerapp/core/constants.dart';
import 'package:eminkardeslerapp/core/core_padding.dart';
import 'package:eminkardeslerapp/order/model/cycle_model.dart';
import 'package:eminkardeslerapp/order/model/inside_orders_model.dart';
import 'package:eminkardeslerapp/order/model/orders_model.dart';
import 'package:eminkardeslerapp/order/services/qualityServices/qualityServices.dart';
import 'package:eminkardeslerapp/order/services/workOrdersPersonState/endOfTheDay.dart';
import 'package:eminkardeslerapp/order/services/workOrdersPersonState/endOfTheWorkOrder.dart';
import 'package:eminkardeslerapp/providers/final_screen_providers.dart';
import 'package:eminkardeslerapp/screens/operationPage/viewModel/operationViewModel.dart';
import 'package:eminkardeslerapp/screens/operationPage/widgets/components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../home_page.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class StopReasons {
  final int stopCode;
  final String stopMessage;
  final String stopValue;

  StopReasons(
      {required this.stopCode,
      required this.stopMessage,
      required this.stopValue});
}

class FinalScreen extends StatefulWidget {
  final GetInsideOrdersInfoModel? insideOrders;
  final GetWorkOrdersInfModel? allModels;
  final String? chosenWorkBench;
  final CycleModel? getCycleModel;
  const FinalScreen(
      {Key? key,
      this.insideOrders,
      this.chosenWorkBench,
      this.getCycleModel,
      this.allModels})
      : super(key: key);

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  GetInsideOrdersInfoModel? get insideOrders => widget.insideOrders;
  String? get chosenWorkBench => widget.chosenWorkBench;

  GetWorkOrdersInfModel? get allModels => widget.allModels;
  CycleModel? get getCycleModel => widget.getCycleModel;
  OperationViewModel operationViewModel = OperationViewModel();
  late StreamController<bool> streamController;
  late StreamController<bool> streamControllerStop;
  TextEditingController textController = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  Future<bool> hasConnection() async {
    bool hasInternet = false;
    hasInternet = await InternetConnectionChecker().hasConnection;
    return hasInternet;
  }

  Future<bool> constValues() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('workOrderIE', allModels!.evrakno);
    return true;
  }

  Future<void> getConsValues() async {
    final prefs = await SharedPreferences.getInstance();
    Constants.workOrderIE = prefs.getString('workOrderIE')!;
  }

  @override
  void initState() {
    saveRequiredParameters();
    // readRequiredParameters();
    streamController = BehaviorSubject<bool>();
    streamControllerStop = BehaviorSubject<bool>();
    //  constValues().then((value) => getConsValues());

    super.initState();
  }

  Future<void> saveRequiredParameters() async {
    Map<String, dynamic> currentValues = {
      // "checkState": checkState,
      "evrakNo": allModels?.evrakno,
      "kod": chosenWorkBench,
      "mpsNo": allModels?.evrakno,
      "mamulcode": allModels?.mamulstokkodu.trimRight(),
      "receteCode": allModels?.mamulstokkodu.trimRight(),
      "jobNo":
          "İE.22.036100001", //r_KAYNAKKODU'NU NASIL çekiyorsan aynı şekilde de MMPS10T.JOBNO
      "operator_1": Constants.personelCode,
      "cycleTime": getCycleModel?.bomrecKaynak0Bv,
      "cycleTimeCins": getCycleModel?.bomrecKaynak0Bu.trimRight(),
      "musteriAd": allModels?.musteriAd,
      "mamulAd": allModels?.ad,
    };

    SharedPreferences prefRequired = await SharedPreferences.getInstance();
    // prefRequired.setString("currentValues", jsonEncode(currentValues));
    // var x = prefRequired.getString("currentValues");
    // var json = jsonDecode(x ?? "");
    // print(json["checkState"]);
    // print(json["mpsNo"]);
    //RequiredParameter.requiredEvrakNo = json["mpsNo"];

    RequiredParameter.requiredEvrakNo = prefRequired.getString("evrakNo") ?? "";
    RequiredParameter.requiredKod = prefRequired.getString("kod") ?? "";
    RequiredParameter.requiredMpsNo = prefRequired.getString("mpsNo") ?? "";
    RequiredParameter.requiredMamulcode =
        prefRequired.getString("mamulcode") ?? "";
    RequiredParameter.requiredReceteCode =
        prefRequired.getString("receteCode") ?? "";
    RequiredParameter.requiredJobNo = prefRequired.getString("jobNo") ?? "";
    RequiredParameter.requiredOperator_1 =
        prefRequired.getString("operator_1") ?? "";
    RequiredParameter.requiredCycleTime = prefRequired.getInt("cycleTime") ?? 0;
    RequiredParameter.requiredCycleTimeCins =
        prefRequired.getString("cycleTimeCins") ?? "";
    RequiredParameter.requiredMusteriAd =
        prefRequired.getString("musteriAd") ?? "";
    RequiredParameter.requiredMamulAd = prefRequired.getString("mamulAd") ?? "";
  }

  Future<String> readRequiredParameters() async {
    SharedPreferences prefRequired = await SharedPreferences.getInstance();
    var x = prefRequired.getString("currentValues");
    var json = jsonDecode(x ?? "");
    RequiredParameter.requiredEvrakNo = json["mpsNo"];

    print(RequiredParameter.requiredEvrakNo);

    return json["mpsNo"];
  }

  @override
  void dispose() {
    streamController.close();
    streamControllerStop.close();
    textController.dispose();
    textController2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkStateProvider =
        Provider.of<CheckStateProvider>(context).checkState;

    streamControllerStop.add(checkStateProvider);

    int flexValue_ = 3;
    CustomSize.height = MediaQuery.of(context).size.height;
    CustomSize.width = MediaQuery.of(context).size.width;
    String denemeMMPS = "İE.22.1907";

    int selectedValue = 00;

    List<StopReasons> stopReasons = [
      StopReasons(
        stopCode: 00,
        stopMessage: "Yemek Molası",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 01,
        stopMessage: "Yeni Ürüne geçiş ayarı",
        stopValue: "A",
      ),
      StopReasons(
        stopCode: 02,
        stopMessage: "Takım değişimi",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 03,
        stopMessage: "Tezgah temizliği",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 04,
        stopMessage: "Tezgah arızası",
        stopValue: "D",
      ),
      StopReasons(
        stopCode: 05,
        stopMessage: "Elektrik kesintisi",
        stopValue: "D",
      ),
      StopReasons(
        stopCode: 06,
        stopMessage: "Pota Bekleme",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 07,
        stopMessage: "Kalıp Onarımı",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 08,
        stopMessage: "Diğer tezhah/Diğer iş",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 09,
        stopMessage: "Diğer",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 100,
        stopMessage: "Fırın bekleme",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 110,
        stopMessage: "Makine ayar",
        stopValue: "A",
      ),
      StopReasons(
        stopCode: 120,
        stopMessage: "Pota Boşaltma",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 310,
        stopMessage: "Taş Değişimi",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 320,
        stopMessage: "Taş bileme",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 400,
        stopMessage: "Külçe Yapımı",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 500,
        stopMessage: "Ambar",
        stopValue: "P",
      ),
      StopReasons(
        stopCode: 600,
        stopMessage: "Hava arızası",
        stopValue: "D",
      ),
    ];

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: flexValue_,
              child: Padding(
                padding: ProjectPaddingCore().paddingAllLow,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: Constants.cardBorderRadius,
                      color: Colors.white60),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: ProjectPaddingCore().paddingAllLow,
                          child: Container(
                            width: CustomSize.width,
                            decoration: BoxDecoration(
                              color: !checkStateProvider
                                  ? Colors.green.shade900
                                  : Colors.red,
                              borderRadius: Constants.cardBorderRadius,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(
                                  child: Text(
                                    !checkStateProvider
                                        ? "Operasyon Devam Ediyor."
                                        : "Operasyon Durduruldu.",
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: ProjectPaddingCore().paddingAllLow,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: Constants.cardBorderRadius,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      StreamBuilder<bool>(
                                          stream: streamControllerStop.stream,
                                          builder: (context, snapshot) {
                                            switch (snapshot.data) {
                                              case true:
                                                return Expanded(
                                                  child: Padding(
                                                    padding:
                                                        ProjectPaddingCore()
                                                            .paddingAllLow,
                                                    child: InkWell(
                                                      highlightColor: Colors
                                                          .blue
                                                          .withOpacity(0.3),
                                                      splashColor: Colors.yellow
                                                          .withOpacity(0.8),
                                                      onTap: () {
                                                        showDialog<void>(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    side: const BorderSide(
                                                                        color: Colors
                                                                            .blueGrey,
                                                                        width:
                                                                            2)),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                content:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 200,
                                                                    width: 400,
                                                                    child: StreamBuilder<
                                                                            bool>(
                                                                        stream: streamController
                                                                            .stream,
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          return Center(
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.center,
                                                                              width: 250,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: SizedBox(
                                                                                          height: CustomSize.height * 0.08,
                                                                                          child: RawMaterialButton(
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                            fillColor: Colors.red,
                                                                                            onPressed: () async {
                                                                                              Map<String, dynamic> body = {
                                                                                                //  "evrakNo": RequiredParameter.requiredEvrakNo,
                                                                                                //  "kod": RequiredParameter.requiredKod,
                                                                                                "mpsNo": RequiredParameter.requiredMpsNo,
                                                                                                "d7IslemKodu": stopReasons.firstWhere((element) => element.stopCode == selectedValue).stopValue,
                                                                                                //  "stopReason": selectedValue.toString().padLeft(2, "0"),
                                                                                                //  "mamulcode": RequiredParameter.requiredMamulcode,
                                                                                                //  "receteCode": RequiredParameter.requiredReceteCode,
                                                                                                "jobNo": RequiredParameter.requiredJobNo, //r_KAYNAKKODU'NU NASIL çekiyorsan aynı şekilde de MMPS10T.JOBNO
                                                                                                //  "operator_1": RequiredParameter.requiredOperator_1,

                                                                                                //  "cycleTime": RequiredParameter.requiredCycleTime,
                                                                                                // "cycleTimeCins": RequiredParameter.requiredCycleTimeCins,
                                                                                              };
                                                                                              await QualityServices.continueProcess(body);

                                                                                              streamControllerStop.add(false);
                                                                                              Navigator.pop(context);
                                                                                              Provider.of<CheckStateProvider>(context, listen: false).checkStateFun();
                                                                                            },
                                                                                            child: const Text("Devam Et"),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Ink(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: Constants
                                                              .cardBorderRadius,
                                                          color: Colors.white,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Devam Et",
                                                            style:
                                                                finalScreenTextStyle(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              case false:
                                                return Expanded(
                                                  child: Padding(
                                                    padding:
                                                        ProjectPaddingCore()
                                                            .paddingAllLow,
                                                    child: InkWell(
                                                      highlightColor: Colors
                                                          .blue
                                                          .withOpacity(0.3),
                                                      splashColor: Colors.yellow
                                                          .withOpacity(0.8),
                                                      onTap: () {
                                                        showDialog<void>(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    side: const BorderSide(
                                                                        color: Colors
                                                                            .blueGrey,
                                                                        width:
                                                                            2)),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                content:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 200,
                                                                    width: 400,
                                                                    child: StreamBuilder<
                                                                            bool>(
                                                                        stream: streamController
                                                                            .stream,
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          return Center(
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.center,
                                                                              width: 250,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          alignment: Alignment.center,
                                                                                          padding: const EdgeInsets.all(5),
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(20),
                                                                                            border: Border.all(
                                                                                              color: Colors.blueGrey,
                                                                                              width: 2,
                                                                                            ),
                                                                                          ),
                                                                                          child: DropdownButton(
                                                                                            underline: Container(),
                                                                                            isExpanded: false,
                                                                                            value: selectedValue,
                                                                                            items: stopReasons.map((e) {
                                                                                              return DropdownMenuItem(
                                                                                                child: Text(e.stopCode.toString() + " - " + e.stopMessage),
                                                                                                value: e.stopCode,
                                                                                              );
                                                                                            }).toList(),
                                                                                            onChanged: (int? value) {
                                                                                              // This is called when the user selects an item.
                                                                                              selectedValue = value!;
                                                                                              streamController.add(true);
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: SizedBox(
                                                                                          height: CustomSize.height * 0.08,
                                                                                          child: RawMaterialButton(
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                            fillColor: Colors.red,
                                                                                            onPressed: () async {
                                                                                              Map<String, dynamic> body = {
                                                                                                "evrakNo": RequiredParameter.requiredEvrakNo,
                                                                                                "kod": RequiredParameter.requiredKod,
                                                                                                "mpsNo": RequiredParameter.requiredMpsNo,
                                                                                                "d7IslemKodu": stopReasons.firstWhere((element) => element.stopCode == selectedValue).stopValue,
                                                                                                "stopReason": selectedValue.toString().padLeft(2, "0"),
                                                                                                "mamulcode": RequiredParameter.requiredMamulcode,
                                                                                                "receteCode": RequiredParameter.requiredReceteCode,
                                                                                                "jobNo": RequiredParameter.requiredJobNo, //r_KAYNAKKODU'NU NASIL çekiyorsan aynı şekilde de MMPS10T.JOBNO
                                                                                                "operator_1": RequiredParameter.requiredOperator_1,

                                                                                                // "cycleTime": getCycleModel?.bomrecKaynak0Bv,
                                                                                                // "cycleTimeCins": getCycleModel?.bomrecKaynak0Bu.trimRight(),
                                                                                              };
                                                                                              await QualityServices.stopReasonInfo(body);

                                                                                              streamControllerStop.add(true);
                                                                                              Navigator.pop(context);
                                                                                              Provider.of<CheckStateProvider>(context, listen: false).checkStateFun();
                                                                                            },
                                                                                            child: const Text("Duruş Bildir"),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Ink(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: Constants
                                                              .cardBorderRadius,
                                                          color: Colors.white,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Duruş Bildir",
                                                            style:
                                                                finalScreenTextStyle(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );

                                              default:
                                                return Container(
                                                  child: const Text("data"),
                                                );
                                            }
                                          }),
                                      Expanded(
                                        child: Padding(
                                          padding: ProjectPaddingCore()
                                              .paddingAllLow,
                                          child: InkWell(
                                            highlightColor:
                                                Colors.blue.withOpacity(0.3),
                                            splashColor:
                                                Colors.yellow.withOpacity(0.8),
                                            onTap: () {
                                              showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          side:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  width: 2)),
                                                      alignment:
                                                          Alignment.center,
                                                      content: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            height: 300,
                                                            width: 400,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      CustomInputField(
                                                                    inputController:
                                                                        textController,
                                                                    hintText:
                                                                        "Üretim Adedini Giriniz",
                                                                    onChanged:
                                                                        (i) {
                                                                      int i =
                                                                          int.tryParse(textController.text) ??
                                                                              0;
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      CustomInputField(
                                                                    inputController:
                                                                        textController2,
                                                                    hintText:
                                                                        "Fire Adedini Giriniz",
                                                                    onChanged:
                                                                        (p0) {
                                                                      String
                                                                          result =
                                                                          p0 ??
                                                                              "";
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              CustomSize.height * 0.08,
                                                                          child:
                                                                              RawMaterialButton(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                            fillColor:
                                                                                Colors.red,
                                                                            onPressed:
                                                                                () async {
                                                                              FocusScope.of(context).unfocus();

                                                                              await hasConnection().then((value) async {
                                                                                if (value == true) {
                                                                                  AwesomeDialog(
                                                                                          context: context,
                                                                                          width: CustomSize.width * 0.6,
                                                                                          title: "Gün sonu bildirmeye emin misiniz?",
                                                                                          btnOkOnPress: (() {
                                                                                            Map<String, dynamic> body = {
                                                                                              "evrakNo": RequiredParameter.requiredEvrakNo,
                                                                                              "kod": RequiredParameter.requiredKod,
                                                                                              "mpsNo": RequiredParameter.requiredMpsNo,
                                                                                              "d7IslemKodu": "U",
                                                                                              "mamulcode": RequiredParameter.requiredMamulcode,
                                                                                              "receteCode": RequiredParameter.requiredReceteCode,
                                                                                              "jobNo": RequiredParameter.requiredJobNo, //r_KAYNAKKODU'NU NASIL çekiyorsan aynı şekilde de MMPS10T.JOBNO
                                                                                              "operator_1": RequiredParameter.requiredOperator_1,
                                                                                              "cycleTime": RequiredParameter.requiredCycleTime,
                                                                                              "cycleTimeCins": RequiredParameter.requiredCycleTimeCins,
                                                                                              "d7Aksiyon": "C",
                                                                                              "tm_miktar": textController.text,
                                                                                              "fire_miktar": textController2.text,
                                                                                              "operasyonTekrarSayisi": textController.text,
                                                                                            };

                                                                                            EndOfTheDay.endOfTheDay(1, 0, (RequiredParameter.requiredCycleTime / 60)).then((value) async {
                                                                                              if (value != null && value["status"] == 200) {
                                                                                                await QualityServices.endOfDayQuality(body).then((result) async {
                                                                                                  //TODO: write http request and handle the response
                                                                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                                  await prefs.setBool('isHasIE', false);
                                                                                                  Navigator.push(
                                                                                                      context,
                                                                                                      MaterialPageRoute(
                                                                                                        builder: (_) => const Home(screenValue: 0),
                                                                                                      ));
                                                                                                });
                                                                                              } else if (value != null && value["status"] == 400) {
                                                                                                //TODO: This screen will never trigger
                                                                                              } else {
                                                                                                //TODO: handle null return
                                                                                              }
                                                                                            });
                                                                                          }),
                                                                                          btnOkText: "Evet",
                                                                                          btnCancelOnPress: () {},
                                                                                          btnCancelText: "Hayir")
                                                                                      .show();
                                                                                } else {}
                                                                              });
                                                                            },
                                                                            child:
                                                                                const Text("Gün Sonu Ver"),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    );
                                                  });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: StreamBuilder<bool>(
                                                stream:
                                                    streamControllerStop.stream,
                                                builder: (context, snapshot) {
                                                  streamControllerStop
                                                      .add(checkStateProvider);
                                                  switch (snapshot.data) {
                                                    case false:
                                                      return Ink(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: Constants
                                                              .cardBorderRadius,
                                                          color: Colors.white,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Gün Sonu",
                                                            style:
                                                                finalScreenTextStyle(),
                                                          ),
                                                        ),
                                                      );
                                                    case true:
                                                      return Container();

                                                    default:
                                                      return const Text(
                                                          "defaultr");
                                                  }
                                                }),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: ProjectPaddingCore()
                                              .paddingAllLow,
                                          child: InkWell(
                                            highlightColor:
                                                Colors.blue.withOpacity(0.3),
                                            splashColor:
                                                Colors.yellow.withOpacity(0.8),
                                            onTap: () {
                                              showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          side:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  width: 2)),
                                                      alignment:
                                                          Alignment.center,
                                                      content: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            height: 300,
                                                            width: 400,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      CustomInputField(
                                                                    inputController:
                                                                        textController,
                                                                    hintText:
                                                                        "Üretim Adedini Giriniz",
                                                                    onChanged:
                                                                        (p0) {
                                                                      String
                                                                          result =
                                                                          p0 ??
                                                                              "";
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      CustomInputField(
                                                                    inputController:
                                                                        textController2,
                                                                    hintText:
                                                                        "Fire Adedini Giriniz",
                                                                    onChanged:
                                                                        (p0) {
                                                                      String
                                                                          result =
                                                                          p0 ??
                                                                              "";
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              CustomSize.height * 0.08,
                                                                          child:
                                                                              RawMaterialButton(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                            fillColor:
                                                                                Colors.red,
                                                                            onPressed:
                                                                                () async {
                                                                              FocusScope.of(context).unfocus();
                                                                              await hasConnection().then((value) async {
                                                                                if (value == true) {
                                                                                  AwesomeDialog(
                                                                                          context: context,
                                                                                          width: CustomSize.width * 0.6,
                                                                                          title: "İş emrini bitirmek için emin misiniz?",
                                                                                          btnOkOnPress: (() {
                                                                                            Map<String, dynamic> body = {
                                                                                              "evrakNo": RequiredParameter.requiredEvrakNo,
                                                                                              "kod": RequiredParameter.requiredKod,
                                                                                              "mpsNo": RequiredParameter.requiredMpsNo,
                                                                                              "d7IslemKodu": "U",
                                                                                              "mamulcode": RequiredParameter.requiredMamulcode,
                                                                                              "receteCode": RequiredParameter.requiredReceteCode,
                                                                                              "jobNo": RequiredParameter.requiredJobNo, //r_KAYNAKKODU'NU NASIL çekiyorsan aynı şekilde de MMPS10T.JOBNO
                                                                                              "operator_1": RequiredParameter.requiredOperator_1,
                                                                                              "cycleTime": RequiredParameter.requiredCycleTime,
                                                                                              "cycleTimeCins": RequiredParameter.requiredCycleTimeCins,
                                                                                              "d7Aksiyon": "E",
                                                                                              "tm_miktar": textController.text,
                                                                                              "fire_miktar": textController2.text,
                                                                                              "operasyonTekrarSayisi": textController.text,
                                                                                            };

                                                                                            EndOfTheWorkOrder.endOfTheWorkOrder().then((value) async {
                                                                                              if (value != null && value["status"] == 200) {
                                                                                                await QualityServices.endOfWorkQuality(body).then((result) async {
                                                                                                  //TODO: write http request and handle the response
                                                                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                                  await prefs.setBool('isHasIE', false);
                                                                                                  Navigator.push(
                                                                                                      context,
                                                                                                      MaterialPageRoute(
                                                                                                        builder: (_) => const Home(screenValue: 0),
                                                                                                      ));
                                                                                                });
                                                                                              } else if (value != null && value["status"] == 400) {
                                                                                                //TODO: This screen will never trigger
                                                                                              } else {
                                                                                                //TODO: handle null return
                                                                                              }
                                                                                            });
                                                                                          }),
                                                                                          btnOkText: "Evet",
                                                                                          btnCancelOnPress: () {},
                                                                                          btnCancelText: "Hayir")
                                                                                      .show();
                                                                                } else {}
                                                                              });
                                                                            },
                                                                            child:
                                                                                const Text("İş Emrini Bitir"),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    );
                                                  });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: StreamBuilder<bool>(
                                                stream:
                                                    streamControllerStop.stream,
                                                builder: (context, snapshot) {
                                                  streamControllerStop
                                                      .add(checkStateProvider);
                                                  switch (snapshot.data) {
                                                    case false:
                                                      return Ink(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: Constants
                                                              .cardBorderRadius,
                                                          color: Colors.white,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "İş Emri Bitir",
                                                            style:
                                                                finalScreenTextStyle(),
                                                          ),
                                                        ),
                                                      );
                                                    case true:
                                                      return Container();

                                                    default:
                                                      return const Text(
                                                          "defaultr");
                                                  }
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: ProjectPaddingCore().paddingAllLow,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: customContainer_(
                          customHeight: CustomSize.height,
                          customWidth: CustomSize.width,
                          denemeMMPS: allModels?.evrakno ??
                              RequiredParameter.requiredEvrakNo,
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: CustomSize.height,
                          customWidth: CustomSize.width,
                          denemeMMPS: allModels?.ad ??
                              RequiredParameter.requiredMamulAd,
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                            customHeight: CustomSize.height,
                            customWidth: CustomSize.width,
                            denemeMMPS:
                                ("Çevrim Süresi: ${getCycleModel?.bomrecKaynak0Bv.toString()} Saniye")),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: CustomSize.height,
                          customWidth: CustomSize.width,
                          denemeMMPS: allModels?.musteriAd ??
                              RequiredParameter.requiredMusteriAd,
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: CustomSize.height,
                          customWidth: CustomSize.width,
                          denemeMMPS: Constants.personelName,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle finalScreenTextStyle() {
    return const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }
}

class customContainer_ extends StatelessWidget {
  const customContainer_({
    Key? key,
    required this.customHeight,
    required this.customWidth,
    required this.denemeMMPS,
  }) : super(key: key);

  final double customHeight;
  final double customWidth;
  final String denemeMMPS;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: customHeight * 0.15,
        width: customWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade800),
        child: Center(
            child: Text(
          denemeMMPS,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({Key? key}) : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: const Color.fromARGB(255, 109, 21, 14),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      isExpanded: true,
    );
  }
}
