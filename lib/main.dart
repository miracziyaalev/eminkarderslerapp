import 'package:eminkardeslerapp/core/auth/auth_manager.dart';
import 'package:eminkardeslerapp/login/login.dart';
import 'package:eminkardeslerapp/screens/countdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<AuthenticationManager>(
        create: (context) => AuthenticationManager(context: context),
        lazy: true,
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const CountDown(),
      theme: ThemeData.dark().copyWith(),
    );
  }
}
