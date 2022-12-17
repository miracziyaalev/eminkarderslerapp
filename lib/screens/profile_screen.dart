import 'dart:async';

import 'package:eminkardeslerapp/core/core_padding.dart';
import 'package:eminkardeslerapp/screens/operationPage/widgets/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../core/constants.dart';
import '../login/model/get_user_model.dart';
import '../login/service/user_model_service.dart';

enum STATE { loadingScreen, loadedScreen, connectionErrorScreen }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late StreamController<STATE> streamController;
  late GetUserInfoModel singleUserModel;

  @override
  void initState() {
    streamController = BehaviorSubject<STATE>();
    getSingleUser();
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  void getSingleUser() {
    streamController.add(STATE.loadingScreen);
    UserInfoService.fetchUserInfo().then((value) async {
      if (value != null) {
        singleUserModel = value;
        Constants.personelCode = singleUserModel.code;
        Constants.personelName = singleUserModel.name;

        if (!streamController.isClosed) {
          streamController.add(STATE.loadedScreen);
        }
      } else {
        !streamController.isClosed
            ? streamController.add(STATE.connectionErrorScreen)
            : null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<STATE>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case STATE.loadingScreen:
                return const Center(
                  child: CustomCircularIndicator(
                      currentDotColor: Color.fromARGB(255, 105, 15, 8),
                      defaultDotColor: Colors.blueGrey,
                      numDots: 10),
                );
              case STATE.loadedScreen:
                return Padding(
                  padding: ProjectPaddingCore().paddingAllHigh,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: AssetImage("assets/image.jpg"),
                                fit: BoxFit.fill,
                              ),
                              color: Colors.blueGrey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CardFb2(
                                text: singleUserModel.code,
                                subtitle: 'Personel Kodu',
                                onPressed: () {}),
                            CardFb2(
                                text: singleUserModel.name,
                                subtitle: 'İsim',
                                onPressed: () {}),
                            CardFb2(
                                text: singleUserModel.adress,
                                subtitle: 'Adres',
                                onPressed: () {}),
                            CardFb2(
                                text: singleUserModel.department,
                                subtitle: 'Departman',
                                onPressed: () {}),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CardFb2(
                                text: singleUserModel.pozition,
                                subtitle: 'Pozisyon',
                                onPressed: () {}),
                            CardFb2(
                                text: singleUserModel.username,
                                subtitle: 'Kullanıcı adı',
                                onPressed: () {}),
                            CardFb2(
                                text: singleUserModel.email,
                                subtitle: 'E-mail',
                                onPressed: () {}),
                            CardFb2(
                                text: '05363603060',
                                subtitle: 'Telefon Numarası',
                                onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              case STATE.connectionErrorScreen:
                return const Center(child: Text("connectionError"));
              default:
                return const Center(child: Text("default"));
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh_rounded),
        backgroundColor: const Color.fromARGB(255, 131, 5, 5),
        onPressed: (() {
          getSingleUser();
        }),
      ),
    );
  }
}

class CardFb2 extends StatelessWidget {
  final String text;

  final String subtitle;
  final Function() onPressed;

  const CardFb2(
      {required this.text,
      required this.subtitle,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: ProjectPaddingCore().paddingAllLow,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.22,
          height: 75,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.05)),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Text(text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              const Spacer(),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
