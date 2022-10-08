import 'package:eminkardeslerapp/core/core_image.dart';
import 'package:eminkardeslerapp/login/login.dart';
import 'package:eminkardeslerapp/screens/countdown.dart';
import 'package:eminkardeslerapp/screens/orders/dynamic_work_orders.dart';
import 'package:flutter/material.dart';

import 'documents.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customWidth = MediaQuery.of(context).size.width;
    var customHeight = MediaQuery.of(context).size.height;

    const List<Tab> myTabs = <Tab>[
      Tab(text: 'Dökümanlar', icon: Icon(Icons.document_scanner)),
      Tab(text: 'İş Emirleri', icon: Icon(Icons.workspace_premium_sharp)),
      Tab(text: 'Zaman', icon: Icon(Icons.timelapse_sharp)),
    ];

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Emin Kardeşler'),
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(255, 151, 37, 2),
            tabs: myTabs,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: const TabBarView(children: [
          Documents(),
          DynamicWorkOrder(),
          CountDown(),
        ]),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageItemsCore().miracFoto),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(child: Column()),
              Column(
                children: [
                  const Center(child: Text('Mirac Ziya Alev')),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              }),
                              child: const Icon(Icons.power_settings_new_sharp,
                                  size: 53)),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget customElevatedButton2({
  required String insideText,
}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
    child: SizedBox(
      width: 120,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.white),
        onPressed: () {},
        child: Text(
          insideText,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    ),
  );
}

class SearchFieldDrawer extends StatelessWidget {
  const SearchFieldDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return TextField(
      style: const TextStyle(color: color, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(
          Icons.search,
          color: color,
          size: 20,
        ),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }
}
