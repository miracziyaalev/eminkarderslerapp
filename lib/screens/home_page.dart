import 'package:eminkardeslerapp/core/constants.dart';
import 'package:eminkardeslerapp/screens/LoginScreen/LoginScreenView/final_login_screen.dart';
import 'package:eminkardeslerapp/screens/final_machine.dart';
import 'package:eminkardeslerapp/screens/final_screen.dart';
import 'package:eminkardeslerapp/screens/orders/work_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_screen.dart';

class Home extends StatefulWidget {
  final int screenValue;
  const Home({Key? key, required this.screenValue}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var customWidth = MediaQuery.of(context).size.width;
    var customHeight = MediaQuery.of(context).size.height;

    const List<Tab> myTabs = <Tab>[
      Tab(text: 'Profil Sayfası', icon: Icon(Icons.person_outline_rounded)),
      Tab(text: 'İş Emirleri', icon: Icon(Icons.workspace_premium_sharp)),
      Tab(text: 'Operasyon', icon: Icon(Icons.timelapse_sharp)),
      Tab(
          text: 'Üretim Sahası',
          icon: Icon(Icons.auto_awesome_mosaic_outlined)),
    ];

    return DefaultTabController(
      initialIndex: widget.screenValue,
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
          ProfileScreen(),
          WorkOrdersScreen(),
          FinalScreen(),
          FinalMachineState()
        ]),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(child: Column()),
              Column(
                children: [
                  Center(child: Text(Constants.userName)),
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
                              onTap: (() async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FinalLoginScreen()),
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
