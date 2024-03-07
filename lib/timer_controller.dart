import 'dart:async';

import 'package:get/get.dart';
import 'package:timer_test/generator.dart';

class TimerController extends GetxController {
  var isPressDown = false.obs;
  late Stopwatch stopwatch;
  late Timer _timer;
  var durationString = ''.obs;
  var scramble = ''.obs;
  @override
  void onInit() {
    stopwatch = Stopwatch();
    durationString.value = _formatDuration(stopwatch.elapsed);
    scramble.value = Generator.generate3x3Scramble();
    super.onInit();
    // TODO: implement onInit
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      if (stopwatch.isRunning) {
        durationString.value = _formatDuration(stopwatch.elapsed);
      }
    });
  }

  void toggleTimer() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      scramble.value = Generator.scramble();
      durationString.value = _formatDuration(stopwatch.elapsed);
    } else {
      // stopwatch.start();
      startTimer();
    }
  }

  void resetTimer() {
    stopwatch.reset();
    if (!stopwatch.isRunning) {
      durationString.value = _formatDuration(stopwatch.elapsed);
      scramble.value = Generator.generate3x3Scramble();
    }
  }

  String _formatDuration(Duration duration) {
    String inMin = (duration.inMinutes % 60).toString();
    if (inMin != '0') {
      inMin = '$inMin:';
    } else {
      inMin = '';
    }
    if (stopwatch.isRunning) {
      return '$inMin${(duration.inSeconds % 60).toString()}.${(duration.inMilliseconds % 1000 ~/ 100).toString()}';
    } else {
      return '$inMin${(duration.inSeconds % 60).toString()}.${(duration.inMilliseconds % 1000 ~/ 10).toString()}';
    }
  }
}
