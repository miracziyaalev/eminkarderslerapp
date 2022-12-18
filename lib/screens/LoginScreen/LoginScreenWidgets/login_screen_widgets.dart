import 'dart:async';

import 'package:eminkardeslerapp/screens/operationPage/widgets/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../../core/constants.dart';
import '../../../core/core_image.dart';
import '../../../login/service/login_service.dart';
import '../../../product/language/language_items.dart';
import '../../home_page.dart';

class AccesWidget extends StatefulWidget {
  AccesWidget({
    Key? key,
    required this.controllerEmail,
    required this.controllerPassword,
  }) : super(key: key);

  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;

  @override
  State<AccesWidget> createState() => _AccesWidgetState();
}

class _AccesWidgetState extends State<AccesWidget> {
  late StreamController<bool> streamController;
  @override
  void initState() {
    streamController = BehaviorSubject<bool>();
    streamController.add(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomSize.height * 0.08,
      width: CustomSize.width * 0.2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 198, 70, 27),
        ),
        onPressed: () async {
          streamController.add(true);
          await LoginServices.fetchUserLogin(
                  widget.controllerEmail.text, widget.controllerPassword.text)
              .then((value) {
            if (value != null && value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Home(
                          screenValue: 0,
                        )),
              );
            } else if (value != null && !value) {
              streamController.add(false);
              const snackBar = SnackBar(
                content: Text('Login failed'),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              streamController.add(false);
              print("data returned null");
            }
          });
        },
        child: StreamBuilder<Object>(
            stream: streamController.stream,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case false:
                  return const Text("Giriş Yap");
                case true:
                  return CustomCircularIndicator(
                      currentDotColor: Colors.white,
                      defaultDotColor: Colors.blueGrey,
                      numDots: 10);

                default:
                  return Text("defaultr");
              }
            }),
      ),
    );
  }
}

class PasswordFormWidget extends StatelessWidget {
  const PasswordFormWidget({
    Key? key,
    required this.controllerPassword,
  }) : super(key: key);

  final TextEditingController controllerPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 16),
      child: TextFormField(
        controller: controllerPassword,
        //maxLength: 20,
        textInputAction:
            TextInputAction.next, //direkt sonraki textfielda yonlendiriyor
        keyboardType: TextInputType.visiblePassword,
        decoration: _InputDecorater().passwordInput,
      ),
    );
  }
}

class EmailFormWidget extends StatelessWidget {
  const EmailFormWidget({
    Key? key,
    required this.controllerEmail,
  }) : super(key: key);

  final TextEditingController controllerEmail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 16),
      child: TextFormField(
        controller: controllerEmail,
        //maxLength: 20,
        textInputAction:
            TextInputAction.next, //direkt sonraki textfielda yonlendiriyor
        keyboardType: TextInputType.emailAddress,
        decoration: _InputDecorater().userNameInput,
      ),
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
            ImageItemsCore().emkaLogo,
          ),
          fit: BoxFit.cover,
          width: CustomSize.width * 0.6,
          height: CustomSize.height * 0.4,
        ),
      ),
    );
  }
}

class LoginPageTextWidget extends StatelessWidget {
  const LoginPageTextWidget({
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
    hintText: 'Kullanıcı Adınızı Giriniz',

    prefixIcon: Icon(Icons.person),
    iconColor: Colors.red,
    border: OutlineInputBorder(),
    labelText: LanguageItems.userNameTitle,
    //fillColor: Colors.amber,
    //filled: true,
  );

  final passwordInput = const InputDecoration(
    hintText: 'Şifrenizi Giriniz',
    prefixIcon: Icon(Icons.password),
    iconColor: Colors.red,
    border: OutlineInputBorder(),
    labelText: LanguageItems.passwordTitle,
  );
}
