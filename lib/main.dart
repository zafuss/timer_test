import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:timer_test/timer_controller.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  State<TimerApp> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  final timerController = Get.put(TimerController());
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    Color backColor = Theme.of(context).scaffoldBackgroundColor;
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Obx(
        () => Scaffold(
          backgroundColor: timerController.isPressDown.isFalse
              ? backColor
              : Colors.greenAccent,
          body: SafeArea(
            child: KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: (event) {
                if (event is KeyUpEvent &&
                    event.physicalKey == PhysicalKeyboardKey.space) {
                  timerController.isPressDown.value = false;
                  timerController.stopwatch.start();
                  timerController.startTimer();
                }
              },
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      !timerController.isPressDown.value
                          ? Text(
                              textAlign: TextAlign.center,
                              timerController.scramble.value,
                              style: TextStyle(fontSize: 20),
                            )
                          : SizedBox(),
                      Expanded(
                        child: Center(
                            child: Text(
                          timerController.durationString.value,
                          style: TextStyle(fontSize: 60),
                        )),
                      ),
                    ],
                  ),
                  onLongPress: () {
                    print('Long pressed');
                    if (!timerController.stopwatch.isRunning) {
                      timerController.isPressDown.value = true;
                      timerController.resetTimer();
                    }
                  },
                  onLongPressEnd: (details) {
                    timerController.isPressDown.value = false;
                    timerController.stopwatch.start();
                    timerController.startTimer();
                  },
                  onTap: () {
                    timerController.toggleTimer();
                  },
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (details.primaryVelocity! > 0) {
                      // User swiped Left
                      timerController.resetTimer();
                    } else if (details.primaryVelocity! < 0) {
                      timerController.resetTimer();
                      // User swiped Right
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
