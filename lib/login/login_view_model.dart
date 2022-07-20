import 'package:dio/dio.dart';
import 'package:eminkardeslerapp/login/model/user_request_model.dart';
import 'package:eminkardeslerapp/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import './login.dart';

abstract class LoginViewModel extends State<Login> {
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

    print(response);
  }
}
