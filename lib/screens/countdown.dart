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

  bool isCountDown = false;
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
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            height: 300,
            color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildTime(),
                  const SizedBox(height: 40),
                  buildButtons(),
                  const SizedBox(height: 40),
                  Text('$lastDurationOfSayac'),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonWidget(
                  text: isRunning ? 'Durdur' : "Devam",
                  onPressed: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                    } else {
                      startTimer(resets: false);
                    }
                  }),
              const SizedBox(
                width: 12,
              ),
              buttonWidget(
                  text: 'Iptal',
                  onPressed: () {
                    lastDurationOfSayac = duration;

                    stopTimer();
                  })
            ],
          )
        : buttonWidget(
            text: 'Basla',
            onPressed: () {
              startTimer();
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
        buildTimeCard(time: minutes, header: 'DAKIKA'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'SANIYE'),
      ],
    );
  }

  Widget buttonWidget(
          {required String text, required VoidCallback onPressed}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ElevatedButton(onPressed: onPressed, child: Text(text))],
      );

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
                fontSize: 60,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(header),
        ],
      );
}
