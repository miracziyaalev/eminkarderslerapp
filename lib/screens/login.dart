import 'package:eminkardeslerapp/login/service/login_service.dart';
import 'package:eminkardeslerapp/screens/home_page.dart';
import 'package:flutter/material.dart';

import '../core/core_image.dart';
import '../core/core_padding.dart';
import '../product/language/language_items.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String tikButton = 'Giriş Yap';

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    ImageItemsCore().emkaLogo,
                  ),
                ),
                const Expanded(
                  child: Expanded(child: _LoginPageTextWidget()),
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
                        onPressed: () async {
                          await LoginServices.fetchUserLogin(
                                  controllerEmail.text, controllerPassword.text)
                              .then((value) {
                            if (value != null && value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            } else if (value != null && !value) {
                              const snackBar = SnackBar(
                                content: Text('Login failed'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              print("data returned null");
                            }
                          });
                        },
                        child: Text(tikButton),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
