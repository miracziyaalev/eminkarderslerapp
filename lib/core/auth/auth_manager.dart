import 'package:flutter/material.dart';

import 'package:eminkardeslerapp/core/cache/cache_manager.dart';

import '../../home/model/user_model.dart';
import '../../login/login.dart';
import '../cache/cache_manager.dart';

class AuthenticationManager extends CacheManager {
  BuildContext context;
  AuthenticationManager({
    required this.context,
  }) {
    fetchUserLogin();
  }

  bool isLogin = false;
  UserModel? model;

  void removeAllData() {
    isLogin = false;
    model = null;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login()));
  }

  Future<void> fetchUserLogin() async {
    final token = await getToken();

    if (token != null) {
      isLogin = true;
    }
  }
}
