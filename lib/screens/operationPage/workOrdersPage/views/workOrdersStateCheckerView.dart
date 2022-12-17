import 'dart:async';

import 'package:eminkardeslerapp/screens/home_page.dart';
import 'package:eminkardeslerapp/screens/operationPage/workOrdersPage/screens/warningPageViewWorkOrder.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants.dart';
import '../../../../order/model/cycle_model.dart';
import '../../../../order/model/inside_orders_model.dart';
import '../../../../order/model/orders_model.dart';

class WorkOrdersStateCheckerView extends StatefulWidget {
  final GetInsideOrdersInfoModel? insideOrders;
  final GetWorkOrdersInfModel? allModels;
  final String? chosenWorkBench;
  final CycleModel? getCycleModel;
  const WorkOrdersStateCheckerView({
    Key? key,
    this.insideOrders,
    this.allModels,
    this.chosenWorkBench,
    this.getCycleModel,
  }) : super(key: key);

  @override
  State<WorkOrdersStateCheckerView> createState() =>
      _WorkOrdersStateCheckerViewState();
}

class _WorkOrdersStateCheckerViewState
    extends State<WorkOrdersStateCheckerView> {
  GetInsideOrdersInfoModel? get insideOrders => widget.insideOrders;
  String? get chosenWorkBench => widget.chosenWorkBench;

  GetWorkOrdersInfModel? get allModels => widget.allModels;
  CycleModel? get getCycleModel => widget.getCycleModel;
  late StreamController<bool> streamControllerWorkOrder;
 
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
    streamControllerWorkOrder = BehaviorSubject();

    isHasIEChecker().then((value) {
      if (value) {
        streamControllerWorkOrder.add(true);
      } else {
        streamControllerWorkOrder.add(false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamControllerWorkOrder.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: streamControllerWorkOrder.stream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case true:
                return WarningPageWorkOrderView(
                  allModels: allModels,
                  chosenWorkBench: chosenWorkBench,
                  getCycleModel: getCycleModel,
                  insideOrders: insideOrders,
                );
              case false:
                return const Home(screenValue: 1);
              default:
                return const Center(child: Text("default"));
            }
          }),
    );
  }
}
