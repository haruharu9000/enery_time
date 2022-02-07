import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled2/widget/button_widget.dart';
import 'package:untitled2/widget/gradient_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Countdown Timer';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark(),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const maxSeconds = 18000;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    /// For real apps change Duration to --> seconds: 1
    timer = Timer.periodic(Duration(milliseconds: 10), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('every time'),
          backgroundColor: Color(0xFF84b9cb),
        ),
        body: GradientWidget(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimer(),
                const SizedBox(height: 80),
                buildButtons(),
              ],
            ),
          ),
        ),
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: isRunning ? 'pause' : 'resume',
                onClicked: () {
                  if (isRunning) {
                    stopTimer(reset: false);
                  } else {
                    startTimer(reset: false);
                  }
                },
              ),
              const SizedBox(width: 12),
              ButtonWidget(
                text: 'cancel',
                onClicked: stopTimer,
              ),
            ],
          )
        : ButtonWidget(
            text: 'start timer!',
            color: Color(0xFF00081a),
            backgroundColor: Color(0xFFfffffd),
            onClicked: () {
              startTimer();
            },
          );
  }

  Widget buildTimer() => SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: seconds / maxSeconds, // 1 - seconds / maxSeconds
              valueColor: AlwaysStoppedAnimation(Color(0xFFfffffd)),
              strokeWidth: 12,
              backgroundColor: Color(0xFF84b9cb),
            ),
            Center(child: buildTime()),
          ],
        ),
      );

  bool isVisible = false;

  Widget buildTime() {
    if (seconds == 0) {
      return Icon(Icons.done, color: (Color(0xFFfffffd)), size: 112);
    } else {
      return Visibility(
        child: Text(
          '$seconds',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFfffffd),
            fontSize: 60,
          ),
        ),
        visible: isVisible,
      );
    }
  }
}
