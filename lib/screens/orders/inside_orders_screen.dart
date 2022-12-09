import 'dart:async';

import 'package:eminkardeslerapp/core/core_padding.dart';
import 'package:eminkardeslerapp/order/model/inside_orders_model.dart';
import 'package:eminkardeslerapp/order/model/machine_model.dart';
import 'package:eminkardeslerapp/order/model/order_materials_model.dart';
import 'package:eminkardeslerapp/order/services/inside_orders_service.dart';
import 'package:eminkardeslerapp/order/services/materials_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../order/model/orders_model.dart';
import '../../order/services/tezgah/get_machine_service.dart';

enum STATE { loadingScreen, loadedScreen, connectionErrorScreen }

class InsideOrderScreen extends StatefulWidget {
  const InsideOrderScreen({Key? key}) : super(key: key);

  @override
  State<InsideOrderScreen> createState() => _InsideOrderScreenState();
}

class _InsideOrderScreenState extends State<InsideOrderScreen> {
  late StreamController<STATE> streamController;
  late List<GetInsideOrdersInfoModel> insideOrders;

  @override
  void initState() {
    streamController = BehaviorSubject<STATE>();
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

  @override
  Widget build(BuildContext context) {
    final model =
        ModalRoute.of(context)!.settings.arguments as GetWorkOrdersInfModel;
    var customWidth2 = MediaQuery.of(context).size.width;
    var customHeight2 = MediaQuery.of(context).size.height;
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
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            ProjectPaddingCore().paddingAllHigh,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Expanded(
                                                    child: Text('İş Emri No:')),
                                                Expanded(
                                                    child: Text('Mamul Adı:')),
                                                Expanded(
                                                    child: Text('Stok Kodu:')),
                                                Expanded(
                                                    child: Text(
                                                        'Üretim Miktarı:')),
                                                Expanded(
                                                    child: Text('Müşteri:')),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            ProjectPaddingCore().paddingAllHigh,
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Text(model.evrakno)),
                                                Expanded(child: Text(model.ad)),
                                                Expanded(
                                                    child: Text(
                                                        model.mamulstokkodu)),
                                                Expanded(
                                                    child: Text(model
                                                        .sFToplammiktar
                                                        .toString())),
                                                Expanded(
                                                    child:
                                                        Text(model.musteriAd)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  height:
                                      MediaQuery.of(context).size.width * 0.22,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage("assets/image.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                      color: Colors.blueGrey),
                                ),
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
                                  height: customHeight2 * 0.2,
                                  width: customWidth2 * 0.4,
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
                                          child: modalBottomSheet(
                                              freeMachineState: machineState,
                                              customHeight2: customHeight2,
                                              item: item,
                                              customWidth2: customWidth2),
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
}

class modalBottomSheet extends StatefulWidget {
  var freeMachineState;

  modalBottomSheet({
    Key? key,
    required this.customHeight2,
    required this.freeMachineState,
    required this.item,
    required this.customWidth2,
  }) : super(key: key);

  final double customHeight2;
  final GetInsideOrdersInfoModel item;

  final double customWidth2;

  @override
  State<modalBottomSheet> createState() => _modalBottomSheetState();
}

class _modalBottomSheetState extends State<modalBottomSheet> {
  List<GetOrdersMaterials>? materials;

  void getMaterial() {
    GetMaterialsOrders.fetchMaterialsData(
            widget.item.evrakNo, widget.item.rSiraNo)
        .then((value) {
      if (value != null) {
        materials = value;
        return materials;
      }
    });
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

  @override
  void initState() {
    getMaterial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var customWidth = MediaQuery.of(context).size.width;
    var customHeight = MediaQuery.of(context).size.height;
    int screenValue = 2;
    var makinaDurum = getMachineStateAvailable();

    return InkWell(
      onTap: () {
        getMaterial();

        showModalBottomSheet<void>(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(70))),
          builder: (BuildContext context) {
            return SafeArea(
              child: Padding(
                padding: ProjectPaddingCore().paddingAllHigh,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: customHeight * 0.1,
                        width: customWidth * 0.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text("   Operasyon: " +
                                      widget.item.operasyonAd),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text("Operasyon Sıra Numarası: " +
                                      widget.item.rSiraNo.toString()),
                                )),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                        child: SizedBox(
                      height: 10,
                    )),
                    Expanded(
                      flex: 9,
                      child: ListView.builder(
                          itemCount: materials?.length,
                          itemBuilder: (BuildContext context, int index) {
                            var iter = materials![index];
                            return Padding(
                              padding: ProjectPaddingCore().paddingAllLow,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blueGrey),
                                height: customHeight * 0.04,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Text(iter.rKaynakkodu))),
                                        Expanded(
                                            flex: 2,
                                            child:
                                                Center(child: Text(iter.ad))),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Text(iter.lotNumber))),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Text(
                                                    iter.rMiktar0.toString()))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: customHeight * 0.1,
                              width: customWidth * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey),
                              child:
                                  const Center(child: Text("Çevrim Süresi: ")),
                            ),
                            InkWell(
                              onTap: (() {
                                GetMachineStateService
                                        .fetchMachineStatesFreeInfo()
                                    .then((value) {
                                  if (value != null) {
                                    var machineStatesFree = value;
                                    DropdownButton(
                                      value:
                                          machineStatesFree.first.workBenchName,
                                      items: machineStatesFree.map((e) {
                                        return DropdownMenuItem(
                                          child: Text(e.workBenchName),
                                          value: e.workBenchName,
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {});
                                      },
                                    );

                                    return showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          AlertDialogFreeStateWidget(
                                              machineStatesFree:
                                                  machineStatesFree),
                                    );
                                  } else {
                                    return showDialog(
                                      context: context,
                                      builder: (context) => const AlertDialog(
                                        title:
                                            Text("Boş Tezgah Bulunmamaktadır."),
                                        actions: [],
                                      ),
                                    );
                                  }
                                });
                              }),
                              borderRadius: BorderRadius.circular(20),
                              child: Ink(
                                height: customHeight * 0.1,
                                width: customWidth * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green),
                                child: const Center(child: Text("İş Emri Al")),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
          height: widget.customHeight2 * 0.5,
          width: widget.customWidth2 * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey[600],
          ),
          child: const Icon(
            Icons.keyboard_double_arrow_down_outlined,
            size: 50,
          )),
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
        onChanged: (dynamic? value) {
          // This is called when the user selects an item.
          setState(() {
            selectedValue = value!;
          });
        },
      ),
    );
  }
}
