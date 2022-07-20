import 'package:eminkardeslerapp/core/auth/auth_manager.dart';
import 'package:eminkardeslerapp/home/home_view.dart';
import 'package:eminkardeslerapp/home/model/user_model.dart';
import 'package:eminkardeslerapp/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Future<void> controlToApp() async {
    await readAuthManager.fetchUserLogin();

    if (readAuthManager.isLogin) {
      await Future.delayed(const Duration(seconds: 1));
      readAuthManager.model = UserModel.fake();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeView()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
    }
  }

  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();

  @override
  void initState() {
    super.initState();
    controlToApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
