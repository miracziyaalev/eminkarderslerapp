import 'package:eminkardeslerapp/core/constants.dart';
import 'package:eminkardeslerapp/login/model/get_user_model.dart';
import 'package:eminkardeslerapp/order/model/cycle_model.dart';
import 'package:eminkardeslerapp/order/model/inside_orders_model.dart';
import 'package:eminkardeslerapp/order/model/orders_model.dart';
import 'package:eminkardeslerapp/screens/LoginScreen/LoginScreenView/final_login_screen.dart';
import 'package:eminkardeslerapp/screens/final_machine.dart';
import 'package:eminkardeslerapp/screens/operationPage/views/OperationStateCheckerView.dart';
import 'package:eminkardeslerapp/screens/operationPage/widgets/components/dialogWidget.dart';
import 'package:eminkardeslerapp/screens/orders/work_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_screen.dart';

class Home extends StatefulWidget {
  final int screenValue;
  final GetInsideOrdersInfoModel? insideOrders;
  final GetUserInfoModel? userSpecificModel;
  final String? chosenWorkBench;
  final CycleModel? getCycleModel;
  final GetWorkOrdersInfModel? allModels;
  const Home(
      {Key? key,
      required this.screenValue,
      this.insideOrders,
      this.chosenWorkBench,
      this.getCycleModel,
      this.allModels,
      this.userSpecificModel})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Future<void> getHasIE() async {
  SharedPreferences prefsS = await SharedPreferences.getInstance();
  Constants.isHasIE = prefsS.getBool('isHasIE');
}

class _HomeState extends State<Home> {
  GetInsideOrdersInfoModel? get insideOrders => widget.insideOrders;
  String? get chosenWorkBench => widget.chosenWorkBench;
  CycleModel? get getCycleModel => widget.getCycleModel;
  GetWorkOrdersInfModel? get allModels => widget.allModels;

  @override
  Widget build(BuildContext context) {
    getHasIE();
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
        body: TabBarView(children: [
          const ProfileScreen(),
          const WorkOrdersScreen(),
          OperationStateCheckerView(
            allModels: allModels,
            getCycleModel: getCycleModel,
            chosenWorkBench: chosenWorkBench,
            insideOrders: insideOrders,
          ),
          const FinalMachineState()
        ]),
        drawer: Drawer(
          child: Stack(
            children: [
              Column(
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
                  Center(child: Text(Constants.personelName)),
                  const SizedBox(height: 100),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: (() async {
                        await getHasIE();
                        if (!Constants.isHasIE!) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          SharedPreferences prefRequired =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          prefRequired.clear();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FinalLoginScreen()),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => DialogFb1(
                                    onPressed: (() {}),
                                  ));
                        }
                      }),
                      child:
                          const Icon(Icons.power_settings_new_sharp, size: 53)),
                ),
              ),
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
