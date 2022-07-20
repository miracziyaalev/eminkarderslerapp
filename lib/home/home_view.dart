import 'package:eminkardeslerapp/core/auth/auth_manager.dart';
import 'package:eminkardeslerapp/core/cache/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/user_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with CacheManager {
  String token = '';

  late UserModel? userModel;

  Future<void> getTokenCache() async {
    token = await getToken() ?? '';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    userModel = context.read<AuthenticationManager>().model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${userModel?.name}'),
      ),
      body: CircleAvatar(
        backgroundImage: NetworkImage(userModel?.imgUrl ?? ''),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthenticationManager(context: context).removeAllData();
          
        },
      ),
    );
  }
}
