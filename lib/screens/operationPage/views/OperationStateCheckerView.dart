import 'dart:async';

import 'package:eminkardeslerapp/screens/operationPage/widgets/screens/final_screen.dart';
import 'package:eminkardeslerapp/screens/operationPage/widgets/screens/warningPageView.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';
import '../../../core/core_image.dart';
import '../../../order/model/cycle_model.dart';
import '../../../order/model/inside_orders_model.dart';
import '../../../order/model/orders_model.dart';

class OperationStateCheckerView extends StatefulWidget {
  final GetInsideOrdersInfoModel? insideOrders;
  final GetWorkOrdersInfModel? allModels;
  final String? chosenWorkBench;
  final CycleModel? getCycleModel;
  const OperationStateCheckerView({
    Key? key,
    this.insideOrders,
    this.allModels,
    this.chosenWorkBench,
    this.getCycleModel,
  }) : super(key: key);

  @override
  State<OperationStateCheckerView> createState() =>
      _OperationStateCheckerViewState();
}

class _OperationStateCheckerViewState extends State<OperationStateCheckerView> {
  GetInsideOrdersInfoModel? get insideOrders => widget.insideOrders;
  String? get chosenWorkBench => widget.chosenWorkBench;

  GetWorkOrdersInfModel? get allModels => widget.allModels;
  CycleModel? get getCycleModel => widget.getCycleModel;

  late StreamController<bool> streamController;

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
    streamController = BehaviorSubject();

    isHasIEChecker().then((value) {
      if (value) {
        streamController.add(true);
      } else {
        streamController.add(false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomSize.width = MediaQuery.of(context).size.width;
    CustomSize.height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case true:
                return FinalScreen(
                  allModels: allModels,
                  chosenWorkBench: chosenWorkBench,
                  getCycleModel: getCycleModel,
                  insideOrders: insideOrders,
                );
              case false:
                return const WarningPageView();
              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Constants.cardBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: Constants.cardBorderRadius,
        child: Image(
          image: AssetImage(
            ImageItemsCore().warningPicture,
          ),
          fit: BoxFit.contain,
          width: CustomSize.width * 0.6,
          height: CustomSize.height * 0.6,
        ),
      ),
    );
  }
}
