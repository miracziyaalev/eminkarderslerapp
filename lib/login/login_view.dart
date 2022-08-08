import 'package:eminkardeslerapp/login/login_resource.dart';
import 'package:eminkardeslerapp/screens/countdown.dart';
import 'package:flutter/material.dart';

import '../core/core_image.dart';
import '../core/core_padding.dart';
import '../product/language/language_items.dart';
import './login_view_model.dart';

class LoginView extends LoginViewModel with LoginResources {
  final String tikButton = 'Giriş Yap';

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: ProjectPaddingCore().paddingAllMedium,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const Expanded(
                    child: SizedBox(
                      height: CoreSizedBox.mediumSizedBoxHeight,
                    ),
                  ),
                  Image.asset(ImageItemsCore().emkaLogo, cacheHeight: 300),
                  Expanded(
                    child: Padding(
                      padding: ProjectPaddingCore().paddingAllLow,
                      child: const Expanded(child: _LoginPageTextWidget()),
                    ),
                  ),
                  const Expanded(child: Text(LanguageItems.appName)),
                  Expanded(
                    child: TextFormField(
                      controller: controllerEmail,
                      //maxLength: 20,
                      textInputAction: TextInputAction
                          .next, //direkt sonraki textfielda yonlendiriyor
                      keyboardType: TextInputType.emailAddress,
                      decoration: _InputDecorater().userNameInput,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: ProjectPaddingCore().paddingVerticalLow,
                      child: Expanded(
                        child: TextFormField(
                          controller: controllerPassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: _InputDecorater().passwordInput,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //  if (formKey.currentState?.validate() ?? false) {
                            //    fetchUserLogin(controllerEmail.text,
                            //        controllerPassword.text);
                            //  }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CountDown()),
                            );
                          },
                          child: Text(tikButton),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginPageTextWidget extends StatelessWidget {
  const _LoginPageTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      LanguageItems.companyName,
      style: Theme.of(context).textTheme.headline5,
      textAlign: TextAlign.center,
    );
  }
}

class CoreSizedBox {
  static const lowSizedBoxHeight = 10.0;
  static const mediumSizedBoxHeight = 20.0;
  static const highSizedBoxHeight = 30.0;
}

class _InputDecorater {
  final emailInput = const InputDecoration(
    prefixIcon: Icon(Icons.mail),
    iconColor: Colors.red,
    border: OutlineInputBorder(),
    labelText: LanguageItems.emailTitle,
    //fillColor: Colors.amber,
    //filled: true,
  );

  final userNameInput = const InputDecoration(
    prefixIcon: Icon(Icons.person),
    iconColor: Colors.red,
    border: OutlineInputBorder(),
    labelText: LanguageItems.userNameTitle,
    //fillColor: Colors.amber,
    //filled: true,
  );

  final passwordInput = const InputDecoration(
    prefixIcon: Icon(Icons.password),
    iconColor: Colors.red,
    border: OutlineInputBorder(),
    labelText: LanguageItems.passwordTitle,
  );
}
