import 'package:eminkardeslerapp/screens/orders/inside_orders.dart';
import 'package:flutter/material.dart';

import '../../order/model/post.dart';

class DynamicWorkOrder extends StatefulWidget {
  const DynamicWorkOrder({Key? key}) : super(key: key);
  @override
  State<DynamicWorkOrder> createState() => _DynamicWorkOrderState();
}

class _DynamicWorkOrderState extends State<DynamicWorkOrder> {
  bool isSearch = false;

  List<WorkOrders> orders = [
    WorkOrders(
      'İE.22.1453',
      'FENER5',
      '53RZE1907',
      '1453',
      '01.09.1907',
      '53.09.2028',
      'ALEVOGLU',
      'assets/fb.jpg',
    ),
    WorkOrders(
      'İE.22.1453',
      'FENER6',
      '53RZE1907',
      '1453',
      '01.09.1907',
      '53.09.2028',
      'ALEVOGLU',
      'assets/fb.jpg',
    ),
    WorkOrders(
      'İE.22.1453',
      'FENER7',
      '53RZE1907',
      '1453',
      '01.09.1907',
      '53.09.2028',
      'ALEVOGLU',
      'assets/fb.jpg',
    ),
    WorkOrders('İE.22.1907', 'DİPCIK TUPU', '01FB1907', '1907', '01.09.1996',
        "10.11.2022", 'KALE KALIP', 'assets/dipciktupu.jpg'),
    WorkOrders('İE.22.1453', 'FENER8', '53RZE1907', '1453', '01.09.1907',
        '53.09.2028', 'ALEVOGLU', 'assets/fb.jpg'),
    WorkOrders('İE.22.1453', 'FENER7', '53RZE1907', '1453', '01.09.1907',
        '53.09.2028', 'ALEVOGLU', 'assets/fb.jpg'),
  ];

  List<WorkOrders> searchList = [];

  void searchFunc(String value) {
    for (var workOrder in orders) {
      if (workOrder.mamulAdi
          .toLowerCase()
          .trim()
          .contains(value.toLowerCase().trim())) {
        searchList.add(workOrder);
        setState(() {
          if (isSearch == false) {
            searchList.clear();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var customWidth = MediaQuery.of(context).size.width;
    var customHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  isSearch = true;
                  searchFunc(value);
                } else if (value.isEmpty) {
                  setState(() {
                    searchList.clear();
                  });
                }
              },
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                  labelText: "Ara",
                  hintText: "DİPÇİK TÜPÜ",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
            const Divider(),
            Expanded(
                child: WorkWidget(
              orders: orders,
              customWidth: customWidth,
              customHeight: customHeight,
              searchList: searchList,
            )),
          ],
        ));
  }
}

class WorkWidget extends StatelessWidget {
  WorkWidget({
    Key? key,
    required this.orders,
    required this.searchList,
    required this.customWidth,
    required this.customHeight,
  }) : super(key: key);

  final List<WorkOrders> orders;
  late List<WorkOrders> searchList = [];
  final double customWidth;
  final double customHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        itemCount: searchList.isNotEmpty ? searchList.length : orders.length,
        itemBuilder: (context, index) {
          var item = searchList.isNotEmpty ? searchList[index] : orders[index];
          return Card(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              width: customWidth,
              height: customHeight * 0.15,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item.foto),
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
                                child: Center(child: Text(item.mpsNo)),
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
                                  child: const Text("MAMUL ADI"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: customWidth,
                                height: customHeight,
                                color: Colors.grey.shade800,
                                child: Center(child: Text(item.mamulAdi)),
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
                                  child: const Text("STOK KODU"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: customWidth,
                                height: customHeight,
                                color: Colors.grey.shade800,
                                child: Center(child: Text(item.stokKodu)),
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
                                  child: const Text("URETIM MIKTARI"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: customWidth,
                                height: customHeight,
                                color: Colors.grey.shade800,
                                child: Center(child: Text(item.uretimMik)),
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
                                  child: const Text('BASLANGIC TARIHI'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: customWidth,
                                height: customHeight,
                                color: Colors.grey.shade800,
                                child:
                                    Center(child: Text(item.baslangicTarihi)),
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
                                  child: const Text('TESLIM TARIHI'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: customWidth,
                                height: customHeight,
                                color: Colors.grey.shade800,
                                child: Center(child: Text(item.teslimTarihi)),
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
                                  child: const Text('MUSTERI ADI'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: customWidth,
                                height: customHeight,
                                color: Colors.grey.shade800,
                                child: Center(child: Text(item.musteriAdi)),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: customWidth,
                          height: customHeight * 0.15,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InsideOrdersPage(
                                          orders: orders[index],
                                        )),
                              );
                            },
                            child: const Icon(Icons.arrow_forward_ios),
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
    );
  }
}
