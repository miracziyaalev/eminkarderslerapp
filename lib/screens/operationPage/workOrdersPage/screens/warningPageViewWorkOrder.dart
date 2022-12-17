import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/core_image.dart';
import '../../../../order/model/cycle_model.dart';
import '../../../../order/model/inside_orders_model.dart';
import '../../../../order/model/orders_model.dart';
import '../../../home_page.dart';
import '../../widgets/components/customButton.dart';

class WarningPageWorkOrderView extends StatefulWidget {
  final GetInsideOrdersInfoModel? insideOrders;
  final GetWorkOrdersInfModel? allModels;
  final String? chosenWorkBench;
  final CycleModel? getCycleModel;
  const WarningPageWorkOrderView({
    Key? key,
    this.insideOrders,
    this.allModels,
    this.chosenWorkBench,
    this.getCycleModel,
  }) : super(key: key);

  @override
  State<WarningPageWorkOrderView> createState() =>
      _WarningPageWorkOrderViewState();
}

class _WarningPageWorkOrderViewState extends State<WarningPageWorkOrderView> {
  GetInsideOrdersInfoModel? get insideOrders => widget.insideOrders;
  String? get chosenWorkBench => widget.chosenWorkBench;

  GetWorkOrdersInfModel? get allModels => widget.allModels;
  CycleModel? get getCycleModel => widget.getCycleModel;

  @override
  Widget build(BuildContext context) {
    CustomSize.width = MediaQuery.of(context).size.width;
    CustomSize.height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: CustomSize.height * 1,
        width: CustomSize.width * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoWidget(),
            const SizedBox(height: 30),
            const Text(
              "Aktif iş emriniz bulunmaktadır.",
              style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 30),
            warningPageButton(
                text: "Operasyon sayfasına yönlendir.",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Home(
                          allModels: allModels,
                          chosenWorkBench: chosenWorkBench,
                          getCycleModel: getCycleModel,
                          insideOrders: insideOrders,
                          screenValue: 2,
                        ),
                      ));
                })
          ],
        ),
      )),
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
      height: 400,
      decoration: BoxDecoration(
        borderRadius: Constants.cardBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: Constants.cardBorderRadius,
        child: Image(
          image: AssetImage(
            ImageItemsCore().warningPicture,
          ),
          fit: BoxFit.fill,
          width: CustomSize.width * 0.4,
          height: CustomSize.height * 0.4,
        ),
      ),
    );
  }
}
