import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/core_image.dart';
import '../../../home_page.dart';
import '../components/customButton.dart';

class WarningPageView extends StatelessWidget {
  const WarningPageView({
    Key? key,
  }) : super(key: key);

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
              "Aktif iş emriniz bulunmamaktadır.",
              style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 30),
            warningPageButton(
                text: "İş Emri Al",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Home(
                          screenValue: 1,
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
