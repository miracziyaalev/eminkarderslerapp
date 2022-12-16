import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eminkardeslerapp/core/constants.dart';
import 'package:eminkardeslerapp/core/core_padding.dart';
import 'package:eminkardeslerapp/order/model/cycle_model.dart';
import 'package:eminkardeslerapp/order/model/inside_orders_model.dart';
import 'package:eminkardeslerapp/order/model/orders_model.dart';
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
    //  constValues().then((value) => getConsValues());

    streamController = BehaviorSubject<bool>();
    streamControllerStop = BehaviorSubject<bool>();
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    streamController.close();
    textController.dispose();
    textController2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkStateProvider = Provider.of<FinalProvider>(context);

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
                              color: !checkStateProvider.checkState
                                  ? Colors.green.shade900
                                  : Colors.red,
                              borderRadius: Constants.cardBorderRadius,
                            ),
                            child: Center(
                              child: Text(
                                !checkStateProvider.checkState
                                    ? "Operasyon Devam Ediyor."
                                    : "Operasyon Durduruldu.",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
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
                                                        child: SizedBox(
                                                          height: 200,
                                                          width: 400,
                                                          child: StreamBuilder<
                                                                  bool>(
                                                              stream:
                                                                  streamController
                                                                      .stream,
                                                              builder: (context,
                                                                  snapshot) {
                                                                return Center(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    width: 250,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
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
                                                                                  onPressed: () {},
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
                                                BorderRadius.circular(20),
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    Constants.cardBorderRadius,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Duruş Bildir",
                                                  style: finalScreenTextStyle(),
                                                ),
                                              ),
                                            ),
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
                                                                              hasConnection().then((value) async {
                                                                                if (value == true) {
                                                                                  await EndOfTheDay.endOfTheDay().then(
                                                                                    (value) {
                                                                                      if (value != null && value.isNotEmpty) {
                                                                                        AwesomeDialog(
                                                                                                width: CustomSize.width * 0.6,
                                                                                                context: context,
                                                                                                title: "Gün sonu bildirmeye emin misiniz?",
                                                                                                btnOkOnPress: () async {
                                                                                                  await EndOfTheDay.endOfTheDay().then((value) {
                                                                                                    AwesomeDialog(
                                                                                                      width: CustomSize.width * 0.6,
                                                                                                      context: context,
                                                                                                      body: Text(value ?? "Unknown"),
                                                                                                      btnOkOnPress: () {},
                                                                                                      btnOkText: "Tamam",
                                                                                                    ).show();
                                                                                                  });
                                                                                                },
                                                                                                btnOkText: "Evet",
                                                                                                btnCancelOnPress: () {},
                                                                                                btnCancelText: "Hayır")
                                                                                            .show();
                                                                                      }
                                                                                    },
                                                                                  );

                                                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                  await prefs.setBool('isHasIE', false);
                                                                                  Future.delayed(const Duration(seconds: 4), () {
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                          builder: (_) => const Home(screenValue: 0),
                                                                                        ));
                                                                                  });
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
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    Constants.cardBorderRadius,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Gün Sonu",
                                                  style: finalScreenTextStyle(),
                                                ),
                                              ),
                                            ),
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
                                                                              hasConnection().then((value) async {
                                                                                if (value == true) {
                                                                                  await EndOfTheWorkOrder.endOfTheWorkOrder().then(
                                                                                    (value) {
                                                                                      if (value != null && value.isNotEmpty) {
                                                                                        AwesomeDialog(
                                                                                                width: CustomSize.width * 0.6,
                                                                                                context: context,
                                                                                                title: "İş emrinin bittiğinden eminiz misiniz?",
                                                                                                btnOkOnPress: () async {
                                                                                                  await EndOfTheWorkOrder.endOfTheWorkOrder().then((value) {
                                                                                                    AwesomeDialog(
                                                                                                      width: CustomSize.width * 0.6,
                                                                                                      context: context,
                                                                                                      body: Text(value ?? "Unknown"),
                                                                                                      btnOkOnPress: () {},
                                                                                                      btnOkText: "Tamam",
                                                                                                    ).show();
                                                                                                  });
                                                                                                },
                                                                                                btnOkText: "Evet",
                                                                                                btnCancelOnPress: () {},
                                                                                                btnCancelText: "Hayır")
                                                                                            .show();
                                                                                      }
                                                                                    },
                                                                                  );

                                                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                  await prefs.setBool('isHasIE', false);
                                                                                  Future.delayed(const Duration(seconds: 4), () {
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                          builder: (_) => const Home(screenValue: 0),
                                                                                        ));
                                                                                  });
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
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    Constants.cardBorderRadius,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "İş Emrini Bitir",
                                                  style: finalScreenTextStyle(),
                                                ),
                                              ),
                                            ),
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
                          denemeMMPS: Constants.workOrderIE,
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: CustomSize.height,
                          customWidth: CustomSize.width,
                          denemeMMPS: allModels?.ad ?? "-",
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: CustomSize.height,
                          customWidth: CustomSize.width,
                          denemeMMPS: "08.11.2022",
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: CustomSize.height,
                          customWidth: CustomSize.width,
                          denemeMMPS: allModels?.musteriAd ?? "-",
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: CustomSize.height,
                          customWidth: CustomSize.width,
                          denemeMMPS: "Miraç Ziya Alev",
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
