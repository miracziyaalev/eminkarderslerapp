import 'package:eminkardeslerapp/order/model/post.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class InsideOrdersPage extends StatelessWidget {
  final WorkOrders orders;

  const InsideOrdersPage({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<InsideOrders> insideOrders = [
      InsideOrders(
        10,
        'IM4-A',
        'İÇ ÇAP İŞLEME',
        4760,
        73,
        5801,
        '',
        true,
      ),
      InsideOrders(
        20,
        'IM-4 DIK ISLEME MERKEZI ',
        'DIS CAP ISLEME',
        4760,
        46,
        3669,
        '',
        true,
      ),
      InsideOrders(
        30,
        'CT2 - CNC TORNA',
        'CNC TORNA ISLEME',
        4760,
        10,
        196,
        '',
        true,
      ),
      InsideOrders(
        40,
        'VB1 - VIBRASYON',
        'VIBRASYON',
        4760,
        10,
        196,
        '',
        true,
      ),
    ];
    var customWidth = MediaQuery.of(context).size.width;
    var customHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detay Sayfasi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: customWidth * 0.4,
                  child: Row(
                    children: [
                      WorkOrdersInfoWidget(
                          customHeight: customHeight, orders: orders),
                      WorkOrdersInfoImgWidget(orders: orders),
                    ],
                  ),
                ),
              ),
              const Divider(),
              InsideOrdersWidget(insideOrder: insideOrders),
            ],
          ),
        ),
      ),
    );
  }
}

class InsideOrdersWidget extends StatelessWidget {
  InsideOrdersWidget({
    Key? key,
    required this.insideOrder,
  }) : super(key: key);

  late List<InsideOrders> insideOrder;

  @override
  Widget build(BuildContext context) {
    var customWidth2 = MediaQuery.of(context).size.width;
    var customHeight2 = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 2,
      child: Container(
        child: Scrollbar(
          child: ListView.builder(
            itemCount: insideOrder.length,
            itemBuilder: ((context, index) {
              var item = insideOrder[index];
              return Card(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.blueGrey),
                  height: customHeight2 * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: customHeight2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Expanded(child: Text('Tezgah')),
                                  Expanded(child: Text('Operasyon')),
                                  Expanded(child: Text('Uretim Miktari')),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: customHeight2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(child: Text(": " + item.tezgah)),
                                  Expanded(
                                      child: Text(": " + item.operasyonAdi)),
                                  Expanded(
                                      child: Text(": " +
                                          item.uretimMiktari.toString())),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: customHeight2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Expanded(child: Text('Toplam Sure/dk')),
                                  Expanded(child: Text('Cevrim Suresi/sn')),
                                  Expanded(child: Text('Recete Notu')),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: customHeight2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: Text(
                                          ": " + item.toplamSure.toString())),
                                  Expanded(
                                      child: Text(
                                          ": " + item.cevrimSuresi.toString())),
                                  Expanded(child: Text(": " + item.receteNotu)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: customHeight2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    item.operasyonNo.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 110),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {},
                              child: AnimatedButton(
                                text: 'Operasyonu Baslat',
                                pressEvent: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.info,
                                    headerAnimationLoop: false,
                                    animType: AnimType.bottomSlide,
                                    title: 'Bilgilendirme',
                                    desc:
                                        'Operasyonu başlatmak istediğinize emin misiniz?',
                                    buttonsTextStyle:
                                        const TextStyle(color: Colors.black),
                                    showCloseIcon: true,
                                    btnCancelText: 'Iptal',
                                    btnOkText: "Tamam",
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  ).show();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class WorkOrdersInfoImgWidget extends StatelessWidget {
  const WorkOrdersInfoImgWidget({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final WorkOrders orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(orders.foto),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

_showInfoDialog(context) {}

class WorkOrdersInfoWidget extends StatelessWidget {
  const WorkOrdersInfoWidget({
    Key? key,
    required this.customHeight,
    required this.orders,
  }) : super(key: key);

  final double customHeight;
  final WorkOrders orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        height: customHeight * 0.3,
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: const Center(child: Text('İş Emri No')),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(child: Text(orders.mpsNo)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: const Center(child: Text('Mamul Adı')),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(child: Text(orders.mamulAdi)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: const Center(child: Text('Stok Kodu')),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(child: Text(orders.stokKodu)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: const Center(child: Text('Üretim Miktarı')),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(child: Text(orders.uretimMik)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: const Center(child: Text('Müşteri')),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(child: Text(orders.musteriAdi)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
