import 'dart:async';

import 'package:eminkardeslerapp/core/constants.dart';
import 'package:eminkardeslerapp/providers/final_screen_providers.dart';
import 'package:eminkardeslerapp/login/service/login_service.dart';
import 'package:eminkardeslerapp/screens/LoginScreen/LoginScreenView/final_login_screen.dart';
import 'package:eminkardeslerapp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

Future<bool> loginChecker() async {
  bool result = false;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Constants.userName = prefs.getString("userName") ?? "";
    Constants.password = prefs.getString("password") ?? "";
    if (Constants.userName.isNotEmpty && Constants.password.isNotEmpty) {
      await LoginServices.fetchUserLogin(Constants.userName, Constants.password)
          .then((value) {
        if (value != null && value) {
          result = true;
        } else {
          result = false;
        }
      });
    } else {
      result = false;
    }
  } catch (e) {
    result = false;
  }
  return result;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamController<bool> streamController;
  @override
  void initState() {
    streamController = BehaviorSubject<bool>();
    loginChecker().then((value) {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FinalProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<bool>(
            stream: streamController.stream,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case true:
                  //homescreen
                  return const Home(
                    screenValue: 0,
                  );
                // return const WarningPageView();
                case false:
                  //loginscreen
                  //return const LoginScreen();
                  return const FinalLoginScreen();

                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            }),
        theme: ThemeData.dark().copyWith(),
      ),
    );
  }
}
