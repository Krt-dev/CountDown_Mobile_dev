import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: CountdownTimerDemo()));
}

class CountdownTimerDemo extends StatefulWidget {
  const CountdownTimerDemo({super.key});

  @override
  State<CountdownTimerDemo> createState() => _CountdownTimerDemoState();
}



class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
   final List<String> fourLetterWords = [
    'HJFE', 'BTWE', 'YTRR', 'DWVB', 'HRBT', 'BTEE', 'NMYE', 'KRTZ',
  ];
  String randomWord = '';
  // Step 2
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 5);
  @override
  void initState() {
    super.initState();
    generateRandomWord();
  }

  void generateRandomWord() {
    final Random random = Random();
    final int randomIndex = random.nextInt(fourLetterWords.length);
    setState(() {
      randomWord = fourLetterWords[randomIndex];
    });
  }
  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(days: 5));
  }
  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    // Step 7
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    Text(
    seconds,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 50),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Timer OTP'),
        backgroundColor: const Color(0xffFF69B4),
        titleTextStyle: const TextStyle( fontSize: 20),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30
            ),
            Text(
              randomWord,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                ),
            ),
            const SizedBox(
              height: 50,
            ),
            // Step 8
            Text(
              seconds,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
            const SizedBox(height: 50),
            // Step 9
            ElevatedButton(
              onPressed: startTimer,
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE91E63), 
              ),
              child: const Text(
                'Send',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 50),
            // Step 10
            ElevatedButton(
              onPressed: () {
                if (countdownTimer == null || countdownTimer!.isActive) {
                  stopTimer();
                }
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff9ACD32), 
              ),
              child: const Text(
                'Stop',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 50),
            // Step 11
            ElevatedButton(
                onPressed: () {
                  resetTimer();
                  startTimer();
                },
                child: const Text(
                  'Resend',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  generateRandomWord();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8A2BE2)
                ),
                child: const Text(
                  'Generate One time code',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              )
          ],
        ),
      ),
    );
  }
}
