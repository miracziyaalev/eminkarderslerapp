import 'dart:async';

import 'package:eminkardeslerapp/order/model/orders_model.dart';
import 'package:eminkardeslerapp/order/services/orders_service.dart';
import 'package:eminkardeslerapp/screens/orders/inside_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum STATE { loadingScreen, loadedScreen, connectionErrorScreen }

class WorkOrdersScreen extends StatefulWidget {
  const WorkOrdersScreen({Key? key}) : super(key: key);

  @override
  State<WorkOrdersScreen> createState() => _WorkOrdersScreenState();
}

class _WorkOrdersScreenState extends State<WorkOrdersScreen> {
  late StreamController<STATE> streamController;
  late List<GetWorkOrdersInfModel> workOrders;
  TextEditingController searchBarController = TextEditingController();
  List<GetWorkOrdersInfModel> allModels = [];

  @override
  void initState() {
    streamController = BehaviorSubject<STATE>();
    getWorkOrders();

    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
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
                return const Center(child: CircularProgressIndicator());
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
                            return Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                width: customWidth,
                                height: customHeight * 0.15,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage('assets/image.jpg'),
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
                                                    child: const Text("MPS NO"),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: customWidth,
                                                  height: customHeight,
                                                  color: Colors.grey.shade800,
                                                  child: Center(
                                                      child:
                                                          Text(item.evrakno)),
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
                                                    child:
                                                        const Text("MAMUL ADI"),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: customWidth,
                                                  height: customHeight,
                                                  color: Colors.grey.shade800,
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
                                                    child:
                                                        const Text("STOK KODU"),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: customWidth,
                                                  height: customHeight,
                                                  color: Colors.grey.shade800,
                                                  child: Center(
                                                      child: Text(
                                                          item.mamulstokkodu)),
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
                                                  color: Colors.grey.shade800,
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
                                                  color: Colors.grey.shade800,
                                                  child: Center(
                                                      child: Text(
                                                          item.egbtariHOfo)),
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
                                                  color: Colors.grey.shade800,
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
                                                  color: Colors.grey.shade800,
                                                  child: Center(
                                                      child:
                                                          Text(item.musteriAd)),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: customWidth,
                                            height: customHeight * 0.15,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const InsideOrderScreen(),
                                                    settings: RouteSettings(
                                                      arguments:
                                                          workOrders[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Icon(
                                                  Icons.arrow_forward_ios),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
