import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eminkardeslerapp/core/core_padding.dart';
import 'package:eminkardeslerapp/order/model/cycle_model.dart';
import 'package:eminkardeslerapp/order/model/inside_orders_model.dart';
import 'package:eminkardeslerapp/order/model/machine_model.dart';
import 'package:eminkardeslerapp/order/model/order_materials_model.dart';
import 'package:eminkardeslerapp/order/services/workOrdersPersonState/add_person_to_ie/add_personal_IE.dart';
import 'package:eminkardeslerapp/order/services/cycle_service.dart';
import 'package:eminkardeslerapp/order/services/inside_orders_service.dart';
import 'package:eminkardeslerapp/order/services/materials_service.dart';
import 'package:eminkardeslerapp/screens/orders/showModalOrders.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../../order/model/orders_model.dart';
import '../../order/services/tezgah/get_machine_service.dart';
import '../home_page.dart';

enum STATE { loadingScreen, loadedScreen, connectionErrorScreen }

class InsideOrderScreen extends StatefulWidget {
  const InsideOrderScreen({Key? key}) : super(key: key);

  @override
  State<InsideOrderScreen> createState() => _InsideOrderScreenState();
}

class _InsideOrderScreenState extends State<InsideOrderScreen> {
  late StreamController<STATE> streamController;
  late StreamController<bool> streamControllerModal;
  late StreamController<bool> streamControllerIsActive;

  late List<GetInsideOrdersInfoModel> insideOrders;
  late List<GetOrdersMaterials> materials;
  late List<GetMachineStateModel> getMachineStateModel;
  late List<CycleModel> getCycleModel;
  late String selectedValue;
  late Future<CycleModel> futureCycle;
  int currentInsideOrderIndex = 0;

  Future<bool> isHasIEChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Constants.isHasIE = prefs.getBool('isHasIE');
    if (Constants.isHasIE == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    streamController = BehaviorSubject<STATE>();
    streamControllerModal = BehaviorSubject<bool>();
    streamControllerIsActive = BehaviorSubject<bool>();

    isHasIEChecker().then((value) {
      if (value) {
        streamControllerIsActive.add(true);
      } else {
        streamControllerIsActive.add(false);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getInsideOrders();

    super.didChangeDependencies();
  }

  void getInsideOrders() {
    final item =
        ModalRoute.of(context)!.settings.arguments as GetWorkOrdersInfModel;
    var temp = item.evrakno;
    String mmpsNo = temp;

    streamController.add(STATE.loadingScreen);

    GetInsideOrdersService.fetchInsideOrdersInfo(mmpsNo).then((value) {
      if (value != null) {
        insideOrders = value;
        if (!streamController.isClosed) {
          streamController.add(STATE.loadedScreen);
        }
      } else {
        !streamController.isClosed
            ? streamController.add(STATE.connectionErrorScreen)
            : null;
      }
    });
  }

  @override
  void dispose() {
    streamController.close();
    streamControllerModal.close();
    streamControllerIsActive.close();
    super.dispose();
  }

  GetMachineStateModel? getMachineStateAvailable() {
    GetMachineStateService.fetchMachineStatesFreeInfo().then((value) {
      if (value != null) {
        var machineStatesFree = value;
        return machineStatesFree;
      }
    });
    return null;
  }

  Future<void> getMaterial(String evrakNo, int rSiraNo) async {
    await GetMaterialsOrders.fetchMaterialsData(evrakNo, rSiraNo).then((value) {
      if (value != null) {
        materials = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final model =
        ModalRoute.of(context)!.settings.arguments as GetWorkOrdersInfModel;
    CustomSize.width = MediaQuery.of(context).size.width;
    CustomSize.height = MediaQuery.of(context).size.height;
    late List<GetWorkOrdersInfModel> workOrders;

    final machineState = getMachineStateAvailable();

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<STATE>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case STATE.loadingScreen:
                return const Center(child: CircularProgressIndicator());
              case STATE.loadedScreen:
                return SizedBox(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: ProjectPaddingCore().paddingAllMedium,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height:
                                      MediaQuery.of(context).size.width * 0.22,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blueGrey),
                                  child: partInfos(model),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                partImage(context, model),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: insideOrders.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = insideOrders[index];
                              return Padding(
                                padding: ProjectPaddingCore().paddingAllMedium,
                                child: Container(
                                  height: CustomSize.height * 0.2,
                                  width: CustomSize.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blueGrey,
                                  ),
                                  child: Padding(
                                    padding:
                                        ProjectPaddingCore().paddingAllMedium,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  "Tezgah:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "Operasyon:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(item.rKaynakKodu),
                                                Text(item.operasyonAd),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  "Üretim Miktarı:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "Reçete Notu:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(item.rYMamulMiktar
                                                    .toString()),
                                                Text(item.receteNotu),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            child: Center(
                                                child: Text(
                                              item.rSiraNo.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 110),
                                            )),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: ModalBottomSheet(
                                              onPressed: () async {
                                            currentInsideOrderIndex = index;
                                            await getMaterial(
                                                insideOrders[index].evrakNo,
                                                insideOrders[index].rSiraNo);
                                            await GetMachineStateService
                                                    .fetchMachineStatesFreeInfo()
                                                .then((value) {
                                              if (value != null &&
                                                  value.isNotEmpty) {
                                                getMachineStateModel = value;
                                                selectedValue =
                                                    value.first.workBenchCode;
                                              }
                                            });
                                            await GetCycleTime.fetchCycleData(
                                                    model.mamulstokkodu,
                                                    item.rSiraNo)
                                                .then(
                                              (value) {
                                                if (value != null &&
                                                    value.isNotEmpty) {
                                                  getCycleModel = value;
                                                }
                                              },
                                            );
                                            await showModalBottomSheet<void>(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      70))),
                                              builder: (BuildContext context) {
                                                return StreamBuilder<bool>(
                                                    stream:
                                                        streamControllerModal
                                                            .stream,
                                                    builder:
                                                        (context, snapshot) {
                                                      return SafeArea(
                                                        child: Padding(
                                                          padding:
                                                              ProjectPaddingCore()
                                                                  .paddingAllHigh,
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    Container(
                                                                  height: CustomSize
                                                                          .height *
                                                                      0.1,
                                                                  width: CustomSize
                                                                          .width *
                                                                      0.55,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: Colors
                                                                          .grey),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Text("   Operasyon:${insideOrders[index].operasyonAd}"),
                                                                          )),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Text("Operasyon Sıra Numarası:${insideOrders[index].rSiraNo} "),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                height: 10,
                                                              )),
                                                              Expanded(
                                                                flex: 9,
                                                                child: materials
                                                                        .isNotEmpty
                                                                    ? ListView.builder(
                                                                        itemCount: materials.length,
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                          var iter =
                                                                              materials[index];
                                                                          return Padding(
                                                                            padding:
                                                                                ProjectPaddingCore().paddingAllLow,
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.blueGrey),
                                                                              height: CustomSize.height * 0.04,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                    children: [
                                                                                      Expanded(flex: 1, child: Center(child: Text(iter.rKaynakkodu))),
                                                                                      Expanded(flex: 2, child: Center(child: Text(iter.ad))),
                                                                                      Expanded(flex: 1, child: Center(child: Text(iter.lotNumber))),
                                                                                      Expanded(flex: 1, child: Center(child: Text(iter.rMiktar0.toString()))),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        })
                                                                    : Container(
                                                                        height:
                                                                            1,
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                  flex: 4,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        height: CustomSize.height *
                                                                            0.1,
                                                                        width: CustomSize.width *
                                                                            0.2,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            color: Colors.grey),
                                                                        child: Center(
                                                                            child:
                                                                                Text("Çevrim Süresi: ${getCycleModel[0].bomrecKaynak0Bv.toString()} ${getCycleModel[0].bomrecKaynak0Bu.toString()} ")),
                                                                      ),
                                                                      DropdownButton(
                                                                        value:
                                                                            selectedValue,
                                                                        items: getMachineStateModel
                                                                            .map((e) {
                                                                          return DropdownMenuItem(
                                                                              child: Text(e.workBenchCode + ' - ' + e.workBenchName),
                                                                              value: e.workBenchCode);
                                                                        }).toList(),
                                                                        onChanged:
                                                                            (String?
                                                                                value) {
                                                                          selectedValue =
                                                                              value ?? getMachineStateModel.first.workBenchName;
                                                                          streamControllerModal
                                                                              .add(true);
                                                                        },
                                                                      ),
                                                                      StreamBuilder<
                                                                              Object>(
                                                                          stream: streamControllerIsActive
                                                                              .stream,
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            switch (snapshot.data) {
                                                                              case false:
                                                                                return InkWell(
                                                                                  onTap: (() async {
                                                                                    AwesomeDialog(
                                                                                            width: CustomSize.width * 0.6,
                                                                                            context: context,
                                                                                            title: "Operasyon baslasın mı ?",
                                                                                            btnOkOnPress: () async {
                                                                                              await AddPersonalIE.addPersonnelIE(selectedValue, model.evrakno, (index + 1) * 10, 11553).then((value) {
                                                                                                AwesomeDialog(
                                                                                                  width: CustomSize.width * 0.6,
                                                                                                  context: context,
                                                                                                  body: Text(value ?? "Unknown"),
                                                                                                  btnOkOnPress: () {
                                                                                                    Navigator.push(
                                                                                                        context,
                                                                                                        MaterialPageRoute(
                                                                                                          builder: (_) => const Home(
                                                                                                            screenValue: 1,
                                                                                                          ),
                                                                                                        ));
                                                                                                  },
                                                                                                  btnOkText: "Tamam",
                                                                                                ).show();
                                                                                                Future.delayed(const Duration(seconds: 4), () {
                                                                                                  Navigator.push(
                                                                                                      context,
                                                                                                      MaterialPageRoute(
                                                                                                        builder: (_) => Home(
                                                                                                          allModels: model,
                                                                                                          getCycleModel: getCycleModel[0],
                                                                                                          chosenWorkBench: selectedValue,
                                                                                                          insideOrders: insideOrders[currentInsideOrderIndex],
                                                                                                          screenValue: 2,
                                                                                                        ),
                                                                                                      ));
                                                                                                });
                                                                                              });
                                                                                            },
                                                                                            btnOkText: "Evet",
                                                                                            btnCancelOnPress: () {},
                                                                                            btnCancelText: "Hayır")
                                                                                        .show();
                                                                                  }),
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                  child: Ink(
                                                                                    height: CustomSize.width * 0.1,
                                                                                    width: CustomSize.width * 0.2,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.green),
                                                                                    child: const Center(child: Text("İş Emri Al")),
                                                                                  ),
                                                                                );
                                                                              case true:
                                                                                return InkWell(
                                                                                  onTap: (() {}),
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                  child: Ink(
                                                                                    height: CustomSize.width * 0.1,
                                                                                    width: CustomSize.width * 0.2,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 79, 8, 3)),
                                                                                    child: const Center(child: Text("Aktif iş Emriniz Bulunmaktadır.")),
                                                                                  ),
                                                                                );
                                                                              default:
                                                                                return InkWell(
                                                                                  onTap: (() {}),
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                  child: Ink(
                                                                                    height: CustomSize.width * 0.1,
                                                                                    width: CustomSize.width * 0.2,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.green),
                                                                                    child: const Center(child: Text("default")),
                                                                                  ),
                                                                                );
                                                                            }
                                                                          }),
                                                                    ],
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              case STATE.connectionErrorScreen:
                return const Center(child: Text("connectionError"));
              default:
                return const Center(child: Text("default returned"));
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getInsideOrders();
        },
        child: const Icon(Icons.replay),
        backgroundColor: const Color.fromARGB(255, 131, 5, 5),
      ),
    );
  }

  Row partInfos(GetWorkOrdersInfModel model) {
    return Row(
      children: [
        infoKeys(),
        infoValues(model),
      ],
    );
  }

  Padding infoKeys() {
    return Padding(
      padding: ProjectPaddingCore().paddingAllHigh,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(child: Text('İş Emri No:')),
              Expanded(child: Text('Mamul Adı:')),
              Expanded(child: Text('Stok Kodu:')),
              Expanded(child: Text('Üretim Miktarı:')),
              Expanded(child: Text('Müşteri:')),
            ],
          ),
        ),
      ),
    );
  }

  Padding infoValues(GetWorkOrdersInfModel model) {
    return Padding(
      padding: ProjectPaddingCore().paddingAllHigh,
      child: Container(
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(model.evrakno)),
              Expanded(child: Text(model.ad)),
              Expanded(child: Text(model.mamulstokkodu)),
              Expanded(child: Text(model.sFToplammiktar.toString())),
              Expanded(child: Text(model.musteriAd)),
            ],
          ),
        ),
      ),
    );
  }

  Container partImage(BuildContext context, GetWorkOrdersInfModel model) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      height: MediaQuery.of(context).size.width * 0.22,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(
                'assets/mamulAssets/${model.mamulstokkodu.trimRight()}.JPG'),
            fit: BoxFit.fill,
          ),
          color: Colors.blueGrey),
    );
  }
}

class AlertDialogFreeStateWidget extends StatefulWidget {
  const AlertDialogFreeStateWidget({
    Key? key,
    required this.machineStatesFree,
  }) : super(key: key);

  final List<GetMachineStateModel> machineStatesFree;

  @override
  State<AlertDialogFreeStateWidget> createState() =>
      _AlertDialogFreeStateWidgetState();
}

class _AlertDialogFreeStateWidgetState
    extends State<AlertDialogFreeStateWidget> {
  String selectedValue = "CNC TORNA 4";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: DropdownButton(
        value: selectedValue,
        items: widget.machineStatesFree.map((e) {
          return DropdownMenuItem(
            child: Text(e.workBenchName),
            value: e.workBenchName,
          );
        }).toList(),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            selectedValue = value!;
          });
        },
      ),
    );
  }
}
