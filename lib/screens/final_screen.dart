import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eminkardeslerapp/core/constants.dart';
import 'package:eminkardeslerapp/core/core_padding.dart';
import 'package:eminkardeslerapp/order/services/workOrdersPersonState/endOfTheDay.dart';
import 'package:eminkardeslerapp/order/services/workOrdersPersonState/endOfTheWorkOrder.dart';
import 'package:eminkardeslerapp/providers/final_screen_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class FinalScreen extends StatelessWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkStateProvider = Provider.of<FinalProvider>(context);

    int flexValue_ = 3;
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;
    String denemeMMPS = "İE.22.1907";
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
                            width: customWidth,
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
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const uretimWidget());
                                              debugPrint("üretim bildir");
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
                                                  "Üretim Bildir",
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
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const fireWidget());
                                              debugPrint("fire bildir");
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
                                                  "Fire Bildir",
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
                                              showModalBottomSheet<void>(
                                                  context: context,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      70))),
                                                  builder:
                                                      (BuildContext context) {
                                                    return const SizedBox(
                                                      height: 300,
                                                      child: stopWidget(),
                                                    );
                                                  });
                                              // showDialog(
                                              //  context: context,
                                              // builder: (context) =>
                                              //      const stopWidget(),
                                              // );
                                              debugPrint("duruş bildir");
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
                          customHeight: customHeight,
                          customWidth: customWidth,
                          denemeMMPS: denemeMMPS,
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: customHeight,
                          customWidth: customWidth,
                          denemeMMPS: "Dipçik Tüpü, 3. Operasyon",
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: customHeight,
                          customWidth: customWidth,
                          denemeMMPS: "08.11.2022",
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: customHeight,
                          customWidth: customWidth,
                          denemeMMPS: "10:00",
                        ),
                      ),
                      Expanded(
                        child: customContainer_(
                          customHeight: customHeight,
                          customWidth: customWidth,
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

class fireWidget extends StatefulWidget {
  const fireWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<fireWidget> createState() => _fireWidgetState();
}

class _fireWidgetState extends State<fireWidget> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Döküm Boşluğu"), value: "510"),
      const DropdownMenuItem(child: Text("Hatalı İşleme"), value: "520"),
      const DropdownMenuItem(child: Text("Kalıp Ayar Hatası"), value: "530"),
      const DropdownMenuItem(child: Text("Döküm Hatası"), value: "540"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final fireMiktar = TextEditingController();
    String? selectedValue = "510";
    return AlertDialog(
      title: const Text("Lütfen fire sebebi ve sayısını bildiriniz."),
      actions: [
        Container(
          child: Column(
            children: [
              DropdownButton(
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                value: selectedValue,
                items: dropdownItems,
                isExpanded: true,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: fireMiktar,
                decoration:
                    const InputDecoration(hintText: "Fire miktarını giriniz."),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Gönder",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "İptal",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class uretimWidget extends StatelessWidget {
  const uretimWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uretimMiktar = TextEditingController();

    return AlertDialog(
      title: const Text("Üretim adedini giriniz;"),
      actions: [
        TextFormField(
          keyboardType: TextInputType.number,
          controller: uretimMiktar,
          decoration:
              const InputDecoration(hintText: "Üretilen adedi giriniz."),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                "Gönder",
                style: TextStyle(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "İptal",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class stopWidget extends StatelessWidget {
  const stopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final finalProvider = Provider.of<FinalProvider>(context, listen: true);
    return AlertDialog(
      title: const Text("Lütfen Duruş Sebebini Seçiniz;"),
      actions: [
        InkWell(
          onTap: () {
            finalProvider.ayarState();
            if (finalProvider.checkState == false) {
              //istek gönderilecek kısım

              debugPrint("sorgu gönder");
            }
          },
          highlightColor: Colors.blue.withOpacity(0.4),
          splashColor: Colors.green.withOpacity(0.5),
          child: Ink(
            height: 150,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: Constants.cardBorderRadius,
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                finalProvider.ayar,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            finalProvider.kesintiState();
            if (finalProvider.checkState == false) {
              //istek gönderilecek kısım

              debugPrint("sorgu gönder");
            }
          },
          highlightColor: Colors.blue.withOpacity(0.4),
          splashColor: Colors.green.withOpacity(0.5),
          child: Ink(
            height: 150,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: Constants.cardBorderRadius,
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                finalProvider.kesinti,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: !finalProvider.checkState
              ? () {
                  debugPrint("mole");
                }
              : null,
          highlightColor: Colors.blue.withOpacity(0.4),
          splashColor: Colors.green.withOpacity(0.5),
          child: Ink(
            height: 150,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: Constants.cardBorderRadius,
              color: Colors.red,
            ),
            child: const Center(
              child: Text(
                "MOLA",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: !finalProvider.checkState
              ? () {
                  debugPrint("lorem");
                }
              : null,
          highlightColor: Colors.blue.withOpacity(0.4),
          splashColor: Colors.green.withOpacity(0.5),
          child: Ink(
            height: 150,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: Constants.cardBorderRadius,
              color: Colors.red,
            ),
            child: const Center(
              child: Text(
                "LOREM",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() async {
            AwesomeDialog(
                    width: CustomSize.width * 0.6,
                    context: context,
                    title: "Gün sonu vermek istediğinize emin misiniz?",
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
          }),
          highlightColor: Colors.blue.withOpacity(0.4),
          splashColor: Colors.green.withOpacity(0.5),
          child: Ink(
            height: 150,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: Constants.cardBorderRadius,
              color: Colors.red,
            ),
            child: const Center(
              child: Text(
                "GÜN SONU",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() async {
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
          }),
          highlightColor: Colors.blue.withOpacity(0.4),
          splashColor: Colors.green.withOpacity(0.5),
          child: Ink(
            height: 150,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: Constants.cardBorderRadius,
              color: Colors.red,
            ),
            child: const Center(
              child: Text(
                "İŞ BİTİMİ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
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
