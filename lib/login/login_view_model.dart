import 'package:dio/dio.dart';
import 'package:eminkardeslerapp/core/auth/auth_manager.dart';
import 'package:eminkardeslerapp/core/cache/cache_manager.dart';
import 'package:eminkardeslerapp/home/model/user_model.dart';
import 'package:eminkardeslerapp/login/model/user_request_model.dart';
import 'package:eminkardeslerapp/login/service/login_service.dart';
import 'package:eminkardeslerapp/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';

import './login.dart';

abstract class LoginViewModel extends State<Login> with CacheManager {
  late final LoginService loginService;

  final _baseUrl = 'https://reqres.in';

  @override
  void initState() {
    super.initState();
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    dio.interceptors.add(PrettyDioLogger());
    loginService = LoginService(dio);
  }

  Future<void> fetchUserLogin(String email, String password) async {
    final response = await loginService
        .fetchLogin(UserRequestModel(email: email, password: password));

    if (response != null) {
      saveToken(response.token ?? '');
      navigateToSplash();
      context.read<AuthenticationManager>().model = UserModel.fake();
    }
  }

  void navigateToSplash() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SplashView()));
  }
}
