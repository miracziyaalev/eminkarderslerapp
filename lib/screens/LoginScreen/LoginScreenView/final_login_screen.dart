import 'package:eminkardeslerapp/core/constants.dart';
import 'package:eminkardeslerapp/core/core_padding.dart';
import 'package:flutter/material.dart';

import '../../../product/language/language_items.dart';
import '../LoginScreenWidgets/login_screen_widgets.dart';

class FinalLoginScreen extends StatefulWidget {
  const FinalLoginScreen({Key? key}) : super(key: key);

  @override
  State<FinalLoginScreen> createState() => _FinalLoginScreenState();
}

class _FinalLoginScreenState extends State<FinalLoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double constHeightValue = 10;
    CustomSize.width = MediaQuery.of(context).size.width;
    CustomSize.height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: ProjectPaddingCore().paddingAllHigh,
        child: SizedBox(
          height: CustomSize.height * 1,
          width: CustomSize.width * 1,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LogoWidget(),
                SizedBox(height: constHeightValue),
                const LoginPageTextWidget(),
                const Text(LanguageItems.appName),
                EmailFormWidget(controllerEmail: controllerEmail),
                PasswordFormWidget(controllerPassword: controllerPassword),
                AccesWidget(
                    controllerEmail: controllerEmail,
                    controllerPassword: controllerPassword)
              ],
            ),
          ),
        ),
      )),
    );
  }
}
