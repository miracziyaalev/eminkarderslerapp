import 'dart:async';

import 'package:eminkardeslerapp/order/model/orders_model.dart';
import 'package:eminkardeslerapp/order/services/orders_service.dart';
import 'package:eminkardeslerapp/screens/operationPage/widgets/components/loading.dart';
import 'package:eminkardeslerapp/screens/orders/inside_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';

enum STATE { loadingScreen, loadedScreen, connectionErrorScreen }

class WorkOrdersScreen extends StatefulWidget {
  const WorkOrdersScreen({Key? key}) : super(key: key);

  @override
  State<WorkOrdersScreen> createState() => _WorkOrdersScreenState();
}

class _WorkOrdersScreenState extends State<WorkOrdersScreen> {
  late StreamController<STATE> streamController;
  late StreamController<bool> streamControllerHasIE;
  late List<GetWorkOrdersInfModel> workOrders;
  TextEditingController searchBarController = TextEditingController();
  List<GetWorkOrdersInfModel> allModels = [];

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
    streamControllerHasIE = BehaviorSubject<bool>();
    getWorkOrders();
    isHasIEChecker().then((value) {
      if (value) {
        streamControllerHasIE.add(true);
      } else {
        streamControllerHasIE.add(false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    streamControllerHasIE.close();
    super.dispose();
  }

  void getWorkOrders() {
    streamController.add(STATE.loadingScreen);
    GetWorkOrdersService.fetchWorkOrdersInfo().then((value) {
      if (value != null) {
        workOrders = value;
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
  Widget build(BuildContext context) {
    var customWidth = MediaQuery.of(context).size.width;
    var customHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder<STATE>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case STATE.loadingScreen:
                return const Center(
                    child: CustomCircularIndicator(
                  currentDotColor: Color.fromARGB(255, 101, 14, 8),
                  defaultDotColor: Colors.blueGrey,
                  numDots: 10,
                ));
              case STATE.loadedScreen:
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 70,
                        child: TextField(
                          controller: searchBarController,
                          onChanged: searchModel,
                          decoration: const InputDecoration(
                              labelText: "İş Emri Ara",
                              hintText: "Dipçik Tüpü",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemCount: allModels.isEmpty
                              ? workOrders.length
                              : allModels.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = allModels.isEmpty
                                ? workOrders[index]
                                : allModels[index];

                            var item2 = allModels.isEmpty
                                ? workOrders[index].mamulstokkodu.trimRight()
                                : allModels[index].mamulstokkodu.trimRight();

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    width: customWidth,
                                    height: customHeight * 0.15,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/mamulAssets/$item2.JPG'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              color: Colors.grey,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        child: const Text(
                                                            "MPS NO"),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: customWidth,
                                                      height: customHeight,
                                                      color:
                                                          Colors.grey.shade800,
                                                      child: Center(
                                                          child: Text(
                                                              item.evrakno)),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              color: Colors.grey,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        child: const Center(
                                                          child: Text(
                                                            "MAMUL ADI",
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: customWidth,
                                                      height: customHeight,
                                                      color:
                                                          Colors.grey.shade800,
                                                      child: Center(
                                                          child: Text(item.ad)),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              color: Colors.grey,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        child: const Text(
                                                            "STOK KODU"),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: customWidth,
                                                      height: customHeight,
                                                      color:
                                                          Colors.grey.shade800,
                                                      child: Center(
                                                          child: Text(item
                                                              .mamulstokkodu)),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              color: Colors.grey,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        child: const Text(
                                                            "URETIM MIKTARI"),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: customWidth,
                                                      height: customHeight,
                                                      color:
                                                          Colors.grey.shade800,
                                                      child: Center(
                                                          child: Text(item
                                                              .sFToplammiktar
                                                              .toString())),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              color: Colors.grey,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        child: const Text(
                                                            'BASLANGIC TARIHI'),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: customWidth,
                                                      height: customHeight,
                                                      color:
                                                          Colors.grey.shade800,
                                                      child: Center(
                                                          child: Text(item
                                                              .egbtariHOfo)),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              color: Colors.grey,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        child: const Text(
                                                            'TESLIM TARIHI'),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: customWidth,
                                                      height: customHeight,
                                                      color:
                                                          Colors.grey.shade800,
                                                      child: Center(
                                                          child: Text(item
                                                              .uretimdentestarih)),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              color: Colors.grey,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        child: const Text(
                                                            'MUSTERI ADI'),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: customWidth,
                                                      height: customHeight,
                                                      color:
                                                          Colors.grey.shade800,
                                                      child: Center(
                                                          child: Text(
                                                              item.musteriAd)),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        StreamBuilder<bool>(
                                            stream:
                                                streamControllerHasIE.stream,
                                            builder: (context, snapshot) {
                                              switch (snapshot.data) {
                                                case false:
                                                  return Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: customWidth,
                                                          height: customHeight *
                                                              0.15,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const InsideOrderScreen(),
                                                                  settings:
                                                                      RouteSettings(
                                                                    arguments:
                                                                        workOrders[
                                                                            index],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: const Icon(Icons
                                                                .arrow_forward_ios),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                case true:
                                                  return Container();
                                                default:
                                                  return Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            width: customWidth,
                                                            height:
                                                                customHeight *
                                                                    0.15,
                                                            child:
                                                                const CustomCircularIndicator(
                                                              currentDotColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          104,
                                                                          9,
                                                                          2),
                                                              defaultDotColor:
                                                                  Colors
                                                                      .blueGrey,
                                                              numDots: 10,
                                                            )),
                                                      ],
                                                    ),
                                                  );
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
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
          getWorkOrders();
        },
        child: const Icon(Icons.replay),
        backgroundColor: const Color.fromARGB(255, 131, 5, 5),
      ),
    );
  }

  void searchModel(String query) {
    final model = workOrders.where((order) {
      final titleLower = order.ad.toLowerCase();
      final input = query.toLowerCase();

      return titleLower.contains(input);
    }).toList();

    setState((() => allModels = model));
  }
}
