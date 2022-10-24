import 'dart:async';

import 'package:eminkardeslerapp/core/core_padding.dart';
import 'package:eminkardeslerapp/order/model/inside_orders_model.dart';
import 'package:eminkardeslerapp/order/services/inside_orders_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../order/model/orders_model.dart';

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

  @override
  Widget build(BuildContext context) {
    final model =
        ModalRoute.of(context)!.settings.arguments as GetWorkOrdersInfModel;
    var customWidth2 = MediaQuery.of(context).size.width;
    var customHeight2 = MediaQuery.of(context).size.height;
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
                                          flex: 1,
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
