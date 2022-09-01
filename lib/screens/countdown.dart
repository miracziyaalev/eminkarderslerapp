import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  static const countDownDuration = Duration(minutes: 10);
  Duration duration = const Duration();
  Timer? timer;
  Duration lastDurationOfSayac = const Duration();
  Duration lastDurationOfAriza = const Duration();
  Duration lastDurationOfBakim = const Duration();
  Duration lastDurationOfKesinti = const Duration();

  bool isCountDown = false;

  bool arizaDeger = false;
  bool bakimDeger = false;
  bool kesintiDeger = false;
  @override
  void initState() {
    reset();
  }

  void reset() {
    if (isCountDown) {
      setState((() => duration = countDownDuration));
    } else {
      setState((() => duration = const Duration()));
    }
  }

  void addTime() {
    final addSeconds = isCountDown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    var customWidth = MediaQuery.of(context).size.width;
    var customHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          SizedBox(
            width: customWidth * 0.4,
            //color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customElevatedButton2(insideText: 'Profil Sayfası'),
                customElevatedButton2(insideText: 'Dökümanlar'),
                customElevatedButton2(insideText: 'İş Emirleri'),
                customElevatedButton2(insideText: 'Zaman'),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.deepOrange.shade900,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildTime(),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        width: customWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildButtonsAriza(durum: 'Arıza'),
                              buildButtonsBakim(durum: 'Bakım'),
                              buildButtonsKesinti(durum: 'Kesinti'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton customElevatedButton({required String insideText}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.white),
        onPressed: () {},
        child: Text(
          insideText,
          style: const TextStyle(color: Colors.black),
        ));
  }

  Widget customElevatedButton2({required String insideText}) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
      child: SizedBox(
        width: 120,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.white),
          onPressed: () {},
          child: Text(
            insideText,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget buildButtonsAriza({required String durum}) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return (isRunning || !isCompleted) && arizaDeger
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSituationCard(
                  duration: lastDurationOfAriza,
                  situation: 'Arıza Durdur',
                  onTap: () {
                    lastDurationOfAriza += duration;
                    arizaDeger = false;
                    stopTimer();
                  })
            ],
          )
        : buildSituationCard(
            duration: lastDurationOfAriza,
            situation: durum,
            onTap: () {
              startTimer();
              print(arizaDeger);
              arizaDeger = true;
              print(arizaDeger);
            });
  }

  void ignoringState() {}

  Widget buildButtonsBakim({required String durum}) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return (isRunning || !isCompleted) && bakimDeger
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSituationCard(
                  duration: lastDurationOfBakim,
                  situation: 'Bakım Durdur',
                  onTap: () {
                    lastDurationOfBakim += duration;
                    bakimDeger = false;
                    stopTimer();
                  })
            ],
          )
        : buildSituationCard(
            duration: lastDurationOfBakim,
            situation: durum,
            onTap: () {
              startTimer();
              bakimDeger = true;
            });
  }

  Widget buildButtonsKesinti({required String durum}) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return (isRunning || !isCompleted) && kesintiDeger
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSituationCard(
                  duration: lastDurationOfKesinti,
                  situation: 'Kesinti Durdur',
                  onTap: () {
                    lastDurationOfKesinti += duration;
                    kesintiDeger = false;

                    stopTimer();
                  })
            ],
          )
        : buildSituationCard(
            duration: lastDurationOfKesinti,
            situation: durum,
            onTap: () {
              startTimer();
              kesintiDeger = true;
            });
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'SAAT'),
        const SizedBox(width: 8),
        buildTimeCard(time: minutes, header: 'DAKİKA'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'SANİYE'),
      ],
    );
  }

  Widget buttonWidget(
          {required String text, required VoidCallback onPressed}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ElevatedButton(onPressed: onPressed, child: Text(text))],
      );

  Widget buildSituationCard(
      {required String situation,
      required VoidCallback onTap,
      required Duration duration}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              situation,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 40,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(duration.toString()),
        ],
      ),
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 160,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            header,
            style: const TextStyle(fontSize: 30),
          ),
        ],
      );
}
